require_relative 'settings_init'

TestLogger.info "The settings library"

json = <<JSON
  {

  }
JSON

settings_file = 'config.json'
settings = Settings.build settings_file

data = settings.get('database_connection')
