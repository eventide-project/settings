ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

## Don't test like this
Settings.activate

require 'test_bench'; TestBench.activate

require 'pp'
require 'securerandom'

require 'settings/controls'
