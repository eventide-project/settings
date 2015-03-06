puts RUBY_DESCRIPTION

require_relative '../init.rb'

TestLogger = Logger.register 'Test Output', name: 'test-output'
