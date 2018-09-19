# -*- encoding: utf-8 -*-
# stub: rhebok 0.9.3 ruby lib
# stub: ext/rhebok/extconf.rb

Gem::Specification.new do |s|
  s.name = "rhebok".freeze
  s.version = "0.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Masahiro Nagano".freeze]
  s.date = "2016-09-14"
  s.description = "High Performance and Optimized Preforked Rack Handler".freeze
  s.email = ["kazeburo@gmail.com".freeze]
  s.extensions = ["ext/rhebok/extconf.rb".freeze]
  s.files = ["ext/rhebok/extconf.rb".freeze]
  s.homepage = "https://github.com/kazeburo/rhebok".freeze
  s.licenses = ["Artistic".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "2.7.3".freeze
  s.summary = "High Performance Preforked Rack Handler".freeze

  s.installed_by_version = "2.7.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<bacon>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<prefork_engine>.freeze, [">= 0.0.7"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<bacon>.freeze, [">= 0"])
      s.add_dependency(%q<rack>.freeze, [">= 0"])
      s.add_dependency(%q<prefork_engine>.freeze, [">= 0.0.7"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<bacon>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<prefork_engine>.freeze, [">= 0.0.7"])
  end
end
