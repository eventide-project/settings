require 'json'
require 'confstruct'

class Settings
  attr_reader :data
  attr_reader :pathname

  def initialize(data, pathname=nil)
    @data = data
    @pathname = pathname
  end

  def self.build(pathname=nil)
    pathname ||= File::Defaults.name

    pathname = File.canonical(pathname)

    File.validate(pathname)

    file_data = read_file(pathname)

    data = Confstruct::Configuration.new(file_data)

    new data, pathname
  end

  def self.read_file(pathname)
    file_data = ::File.open(pathname)

    JSON.load file_data
  end

  def override(override_data)
    data.push!(override_data)
  end

  def reset
    data.pop!
  end

  def set(receiver, *keys)
    keys = data.keys if keys.empty?

    keys.flatten! if keys.is_a? Array

    keys.each {|k| data[k] ? assign_value(receiver, k, data[k]) : nil }
  end

  def assign_value(receiver, attr_name, value)
    attr_name = attr_name.to_sym

    Settings::Setting::Assignment.assign(receiver, attr_name, value)
  end

  def get(*keys)
    keys.flatten! if keys.is_a? Array

    keys.inject(data) {|memo, k| memo ? memo[k] : nil }
  end

  module File
    def self.canonical(pathname)
      if ::File.extname(pathname) == ""
        pathname = (Pathname.new(pathname) + Defaults.name).to_s
      end

      if ::File.dirname(pathname) == "."
        pathname = (Pathname.new(Directory::Defaults.pathname) + pathname).to_s
      end

      pathname
    end

    def self.validate(pathname)
      pathname = Pathname.new pathname

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

  module Directory
    module Defaults
      def self.pathname
        Dir.pwd
      end
    end
  end
end
