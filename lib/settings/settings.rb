require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(path=nil)
    # QUESTION Does this need to be tested again with the nil case since the File defaults have already been tested?
    # Should the path even be optional?

    file = Settings::File.instance

    Settings::File.validate(path)

    pathname = file.pathname

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

    def self.validate(path)
      file = self.instance

      if ::File.directory?(path)
        file.directory = path
      else
        file.directory = ::File.dirname(path)
        file.name = ::File.basename(path)
      end

      filepath = Pathname.new file.pathname

      unless filepath.file?
        raise(Errno::ENOENT, "Settings cannot be read from #{filepath}. The file doesn't exist.")
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
