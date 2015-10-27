require_relative 'test_init'

Runner.!('spec/*.rb') { |exclude| exclude == 'test_init.rb' }
