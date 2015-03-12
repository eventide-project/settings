require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(path)
    pathname = File.canonical(path)

    File.validate(pathname)

    file_data = open_file(pathname)

    data = JSON.load file_data

    new data
  end

  def self.open_file(pathname)
    ::File.open(pathname)
  end

  def get(*key)
    key.flatten! if key.is_a? Array
    key.inject(data) {|memo, k| memo[k] }
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
