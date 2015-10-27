require_relative 'test_init'

Runner.('spec/**/*.rb') do |exclude|
  exclude =~ /integration\.rb|\/skip\.|(_init\.rb|\.sketch\.rb|_sketch\.rb)\z/
end
