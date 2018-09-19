# -*- coding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'rack'
require 'stringio'
require 'tempfile'
require 'socket'
require 'rack/utils'
require 'io/nonblock'
require 'prefork_engine'
require 'rhebok'
require 'rhebok/config'
require 'rhebok/buffered'

$RACK_HANDLER_RHEBOK_GCTOOL = true
begin
  require 'gctools/oobgc'
rescue LoadError
  $RACK_HANDLER_RHEBOK_GCTOOL = false
end

module Rack
  module Handler
    class Rhebok
      MAX_MEMORY_BUFFER_SIZE = 1024 * 1024
      DEFAULT_OPTIONS = {
        :Host => '0.0.0.0',
        :Port => 9292,
        :Path => nil,
        :MaxWorkers => 5,
        :Timeout => 300,
        :MaxRequestPerChild => 1000,
        :MinRequestPerChild => nil,
        :SpawnInterval => nil,
        :ErrRespawnInterval => nil,
        :OobGC => false,
        :MaxGCPerRequest => 5,
        :MinGCPerRequest => nil,
        :BackLog => Socket::SOMAXCONN,
        :BeforeFork => nil,
        :AfterFork => nil,
        :ReusePort => false,
        :ChunkedTransfer => false,
      }
      NULLIO  = StringIO.new("").set_encoding('BINARY')

      def self.run(app, options={})
        slf = new(options)
        slf.setup_listener()
        slf.run_worker(app)
      end

      def self.valid_options
        {
          "Host=HOST" => "Hostname to listen on (default: 0.0.0.0)",
          "Port=PORT" => "Port to listen on (default: 9292)",
        }
      end

      def initialize(options={})
        if options[:OobGC].instance_of?(String)
          options[:OobGC] = options[:OobGC].match(/^(true|yes|1)$/i) ? true : false
        end
        if options[:ReusePort].instance_of?(String)
          options[:ReusePort] = options[:ReusePort].match(/^(true|yes|1)$/i) ? true : false
        end
        if options[:ChunkedTransfer].instance_of?(String)
          options[:ChunkedTransfer] = options[:ChunkedTransfer].match(/^(true|yes|1)$/i) ? true : false
        end

        @options = DEFAULT_OPTIONS.merge(options)
        if @options[:ConfigFile] != nil
          puts "loading from config_file:#{options[:ConfigFile]}"
          config = ::Rhebok::Config.new
          config.instance_eval(::File.read @options.delete(:ConfigFile))
          @options.merge!(config.retrieve)
        end
        @server = nil
        @_is_tcp = false
        @_using_defer_accept = false
      end

      def setup_listener()
        if ENV.has_key?("SERVER_STARTER_PORT") && ENV["SERVER_STARTER_PORT"].to_s.match(/=/)
          hostport, fd = ENV["SERVER_STARTER_PORT"].split("=",2)
          if m = hostport.match(/(.*):(\d+)/)
            @options[:Host] = m[0]
            @options[:Port] = m[1].to_i
          else
            @options[:Port] = hostport
          end
          @server = Socket.for_fd(fd.to_i)
          @_is_tcp = true if !@server.local_address.unix?
        end

        if @server == nil
          if @options[:Path] != nil
            if ::File.socket?(@options[:Path])
              puts "removing existing socket file:#{@options[:Path]}";
              ::File.unlink(@options[:Path])
            end
            begin
              ::File.unlink(@options[:Path])
            rescue
              #ignore
            end
            puts "Rhebok starts Listening on :unix:#{@options[:Path]} Pid:#{$$}"
            oldmask = ::File.umask(0)
            @server = Socket.new(Socket::AF_UNIX, Socket::SOCK_STREAM, 0)
            @server.bind(Addrinfo.unix(@options[:Path]))
            ::File.umask(oldmask)
            @_is_tcp = false
            @options[:Host] = "0.0.0.0"
            @options[:Port] = 0
          else
            puts "Rhebok starts Listening on #{@options[:Host]}:#{@options[:Port]} Pid:#{$$}"
            addrinfo = Addrinfo.tcp(@options[:Host], @options[:Port])
            @server = Socket.new(defined?(Socket::AF_INET6) && addrinfo.afamily == Socket::AF_INET6 ?
                                 Socket::AF_INET6 : Socket::AF_INET, Socket::SOCK_STREAM, 0)
            @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
            if @options[:ReusePort]
              @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEPORT, 1);
            end
            @server.bind(addrinfo)
            @_is_tcp = true
          end
          @server.listen(@options[:BackLog].to_i)
        end # @server == nil

        if RUBY_PLATFORM.match(/linux/) && @_is_tcp == true
          begin
            @server.setsockopt(Socket::IPPROTO_TCP, 9, 1)
            @_using_defer_accept = true
          end
        end

        if @server.respond_to?("autoclose=")
          @server.autoclose = false
        end

      end

      def run_worker(app)
        pm_args = {
          "max_workers" => @options[:MaxWorkers].to_i,
          "trap_signals" => {
            "TERM" => 'TERM',
            "HUP"  => 'TERM',
          },
        }
        if @options[:SpawnInterval]
          pm_args["trap_signals"]["USR1"] = ["TERM", @options[:SpawnInterval].to_i]
          pm_args["spawn_interval"] = @options[:SpawnInterval].to_i
        end
        if @options[:ErrRespawnInterval]
          pm_args["err_respawn_interval"] = @options[:ErrRespawnInterval].to_i
        end
        if @options[:BeforeFork]
          pm_args["before_fork"] = proc { |pe2|
            @options[:BeforeFork].call
          }
        end
        Signal.trap('INT','SYSTEM_DEFAULT') # XXX

        pe = PreforkEngine.new(pm_args)
        while !pe.signal_received.match(/^(TERM|USR1)$/)
          pe.start do
            srand
            if @options[:AfterFork]
              @options[:AfterFork].call
            end
            self.accept_loop(app)
          end
        end

        while pe.wait_all_children(1) > 0
          pe.signal_all_children('TERM')
        end
      end

      def _calc_reqs_per_child
        if @options[:MinRequestPerChild] == nil
          return @options[:MaxRequestPerChild].to_i
        end
        max = @options[:MaxRequestPerChild].to_i
        min = @options[:MinRequestPerChild].to_i
        if min < max
          max - ((max - min + 1) * rand).to_i
        else
          max
        end
      end

      def _calc_gc_per_req
        if @options[:MinGCPerRequest] == nil
          return @options[:MaxGCPerRequest].to_i
        end
        max = @options[:MaxGCPerRequest].to_i
        min = @options[:MinGCPerRequest].to_i
        if min < max
          max - ((max - min + 1) * rand).to_i
        else
          max
        end
      end


      def accept_loop(app)
        @term_received = 0
        proc_req_count = 0
        Signal.trap(:TERM) do
          @term_received += 1
        end
        Signal.trap(:PIPE, "IGNORE")
        max_reqs = self._calc_reqs_per_child()
        gc_reqs = self._calc_gc_per_req()
        fileno = @server.fileno

        env_template = {
          "SERVER_NAME"       => @options[:Host],
          "SERVER_PORT"       => @options[:Port].to_s,
          "rack.version"      => [1,1],
          "rack.errors"       => STDERR,
          "rack.multithread"  => false,
          "rack.multiprocess" => true,
          "rack.run_once"     => false,
          "rack.url_scheme"   => "http",
          "rack.input"        => NULLIO
        }

        while @options[:MaxRequestPerChild].to_i == 0 || proc_req_count < max_reqs
          if @term_received > 0
            exit!(true)
          end
          env = env_template.clone
          connection, buf = ::Rhebok.accept_rack(fileno, @options[:Timeout], @_is_tcp, env)
          if connection
            # for tempfile
            buffer = nil
            begin
              proc_req_count += 1
              # handle request
              if env.key?("CONTENT_LENGTH") && env["CONTENT_LENGTH"].to_i > 0
                cl = env["CONTENT_LENGTH"].to_i
                buffer = ::Rhebok::Buffered.new(cl,MAX_MEMORY_BUFFER_SIZE)
                while cl > 0
                  chunk = ""
                  if buf.bytesize > 0
                    chunk = buf
                    buf = ""
                  else
                    readed = ::Rhebok.read_timeout(connection, chunk, cl, 0, @options[:Timeout])
                    if readed == nil
                      return
                    end
                  end
                  buffer.print(chunk)
                  cl -= chunk.bytesize
                end
                env["rack.input"] = buffer.rewind
              elsif env.key?("HTTP_TRANSFER_ENCODING") && env.delete("HTTP_TRANSFER_ENCODING") == 'chunked'
                buffer = ::Rhebok::Buffered.new(0,MAX_MEMORY_BUFFER_SIZE)
                chunked_buffer = '';
                complete = false
                while !complete
                  chunk = ""
                  if buf.bytesize > 0
                    chunk = buf
                    buf = ""
                  else
                    readed = ::Rhebok.read_timeout(connection, chunk, 16384, 0, @options[:Timeout])
                    if readed == nil
                      return
                    end
                  end
                  chunked_buffer << chunk
                  while chunked_buffer.sub!(/^(([0-9a-fA-F]+).*\015\012)/,"") != nil
                    trailer = $1
                    chunked_len = $2.hex
                    if chunked_len == 0
                      complete = true
                      break
                    elsif chunked_buffer.bytesize < chunked_len + 2
                      chunked_buffer = trailer + chunked_buffer
                      break
                    end
                    buffer.print(chunked_buffer.byteslice(0,chunked_len))
                    chunked_buffer = chunked_buffer.byteslice(chunked_len,chunked_buffer.bytesize-chunked_len)
                    chunked_buffer.sub!(/^\015\012/,"")
                  end
                  break if complete
                end
                env["CONTENT_LENGTH"] = buffer.size.to_s
                env["rack.input"] = buffer.rewind
              end

              status_code, headers, body = app.call(env)

              use_chunked = 0
              if @options[:ChunkedTransfer]
                use_chunked =  env["SERVER_PROTOCOL"] != "HTTP/1.1" ||
                               headers.key?("Transfer-Encoding") ||
                               headers.key?("Content-Length") ? 0 : 1
              end

              if body.instance_of?(Array)
                ::Rhebok.write_response(connection, @options[:Timeout], status_code.to_i, headers, body, use_chunked, 0)
              else
                ::Rhebok.write_response(connection, @options[:Timeout], status_code.to_i, headers, [], use_chunked, 1)
                body.each do |part|
                  ret = nil
                  if use_chunked == 1
                    ret = ::Rhebok.write_chunk(connection, part, 0, @options[:Timeout])
                  else
                    ret = ::Rhebok.write_all(connection, part, 0, @options[:Timeout])
                  end
                  if ret == nil
                    break
                  end
                end #body.each
                ::Rhebok.write_all(connection, "0\015\012\015\012", 0, @options[:Timeout]) if use_chunked == 1
                body.respond_to?(:close) and body.close
              end
              #p [env,status_code,headers,body]
            ensure
              if buffer != nil
                buffer.close
              end
              ::Rhebok.close_rack(connection)
              # out of band gc
              if @options[:OobGC]
                if $RACK_HANDLER_RHEBOK_GCTOOL
                  GC::OOB.run
                elsif proc_req_count % gc_reqs == 0
                  disabled = GC.enable
                  GC.start
                  GC.disable if disabled
                end
              end
            end #begin
          end # accept
        end #while max_reqs
      end #def

    end
  end
end
