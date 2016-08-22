# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'settings'
  s.version = '0.2.0.2'
  s.summary = 'Settings data access and assignment'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/settings'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'telemetry-logger'
  s.add_runtime_dependency 'casing'

  s.add_runtime_dependency 'confstruct'

  s.add_development_dependency 'test_bench'
end
