# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'settings'
  s.version = '0.1.0.0'
  s.summary = 'Settings data access and assignment'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'opensource@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/settings'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'telemetry-logger'

  s.add_runtime_dependency 'confstruct'

  s.add_development_dependency 'test_bench'
end
