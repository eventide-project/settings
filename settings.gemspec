# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'settings'
  s.version = '0.1.1'
  s.summary = 'Settings data access and assignment'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'opensource@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/error_data'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'attribute', '~> 0'
  s.add_runtime_dependency 'telemetry-logger', '~> 0'
  s.add_runtime_dependency 'dependency', '~> 0'

  s.add_runtime_dependency 'confstruct', '0.2.7'

  s.add_development_dependency 'minitest', '~> 1'
  s.add_development_dependency 'minitest-spec-context', '~> 0'
  s.add_development_dependency 'pry', '~> 0'
  s.add_development_dependency 'runner', '~> 0'
end
