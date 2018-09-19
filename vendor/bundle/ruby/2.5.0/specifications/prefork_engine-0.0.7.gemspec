# -*- encoding: utf-8 -*-
# stub: prefork_engine 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "prefork_engine".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Masahiro Nagano".freeze]
  s.date = "2016-09-13"
  s.description = "a simple prefork server framework. ruby port of perl's Parallel::Prefork".freeze
  s.email = ["kazeburo@gmail.com".freeze]
  s.homepage = "https://github.com/kazeburo/prefork_engine/".freeze
  s.licenses = ["Artistic".freeze]
  s.rubygems_version = "2.7.3".freeze
  s.summary = "a simple prefork server framework".freeze

  s.installed_by_version = "2.7.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<proc-wait3>.freeze, ["~> 1.7.2"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<proc-wait3>.freeze, ["~> 1.7.2"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<proc-wait3>.freeze, ["~> 1.7.2"])
  end
end
