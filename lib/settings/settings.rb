require 'json'
require 'confstruct'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(path, override_data=nil)
    pathname = File.canonical(path)

    File.validate(pathname)

    data = read_file(pathname)

    data = override_settings(data, override_data) if override_data

    new data
  end

  def self.read_file(pathname)
    file_data = ::File.open(pathname)

    JSON.load file_data
  end

  def self.override_settings(data, override_data)
    settings_data = Confstruct::Configuration.new(data)

    settings_data.configure(override_data)
  end

  def configure(receiver, *keys)
    keys = data.keys if keys.empty?

    keys.each {|k| data[k] ? receiver.send("#{k}=", data[k]) : nil }
  end

  def get(*key)
    key.flatten! if key.is_a? Array
    key.inject(data) {|memo, k| memo ? memo[k] : nil }
  end

  module File
    def self.canonical(path)
      if ::File.extname(path) == ""
        path = (Pathname.new(path) + Defaults.name).to_s
      end

      path
    end

    def self.validate(filepath)
      pathname = Pathname.new filepath

      unless pathname.file?
        raise(Errno::ENOENT, "Settings cannot be read from #{pathname}. The file doesn't exist.")
      end
    end

    module Defaults
      def self.name
        'settings.json'
      end
    end
  end
end
