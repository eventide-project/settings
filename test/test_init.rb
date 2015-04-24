ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['CONSOLE_COLOR'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'error'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
Settings.activate

TestLogger = ::Telemetry::Logger.get 'Test Output'
