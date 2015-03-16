require_relative 'settings_init'

Settings.activate

settings_data = {
  some_setting: 'some value',
  some_other_setting: 'some other value',
  yet_another_setting: 'yet another value'
}

class Thing
  setting :some_setting
  setting :some_other_setting
  attr_accessor :yet_another_setting
end

thing = Thing.new

settings = Settings.new settings_data

settings.set thing

puts thing.some_setting
# => 'some value'

puts thing.some_other_setting
# => 'some other value'

puts thing.yet_another_setting
# => 'yet another value'
