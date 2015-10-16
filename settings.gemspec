# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'settings'
  s.summary = 'Settings data access'
  s.version = '0.1.0'
  s.authors = ['']
  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency 'confstruct', '0.2.7'

  s.add_runtime_dependency 'telemetry-logger'
  s.add_runtime_dependency 'attribute'
  s.add_runtime_dependency 'dependency'
end
