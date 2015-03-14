require_relative 'settings_init'

class DatabaseConnector
  attr_accessor :username
  attr_accessor :password
  attr_accessor :host
end

database_connector = DatabaseConnector.new

settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")

# => {
#  "username": "some username",
#  "password": "some password",
#  "host": "some host"
#}

settings = Settings.build(settings_file)

settings.configure database_connector

puts database_connector.username
# => "some username"

puts database_connector.password
# => "some password"

puts database_connector.host
# => "some host"
