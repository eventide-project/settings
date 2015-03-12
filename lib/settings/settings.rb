require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(dirpath, filename=nil)
    pathname = Settings::File.build(dirpath, filename)

    file_data = ::File.open(pathname)

    data = JSON.load file_data

    new data
  end

  def get(*key)
    key.flatten! if key.is_a? Array
    key.inject(data) {|memo, k| memo[k] }
  end

  class File
    attr_accessor :directory
    attr_accessor :name

    def self.instance
      @instance ||= new
    end

    def self.build(dirpath, name=nil)
      instance.directory = dirpath
      instance.name = name

      pathname = Pathname.new instance.pathname

      validate(pathname)

      pathname
    end

    def self.validate(pathname)
      unless pathname.file?
        raise(Errno::ENOENT, "Settings cannot be read from #{pathname}. The file doesn't exist.")
      end
    end

    def pathname
      directory = Pathname.new self.directory.to_s
      name = Pathname.new (self.name ||= Defaults.name).to_s

      pathname = (directory + name).to_s
    end

    module Defaults
      def self.name
        'settings.json'
      end
    end
  end
end
