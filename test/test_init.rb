ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['CONSOLE_COLOR'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'trace'
ENV['FILE_LOGGING'] ||= 'on'
ENV['ERROR_FILE_LOGGING'] ||= 'on'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

TestLogger = Logger.register 'Test Output'
