require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(path=nil)
    # Currently have this responding to filepath & dirpath - not sure how passing in a nil will work?
    # Would this make more sense? self.build(dirpath, filename=nil)

    pathname = Settings::File.build(path)

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

    def self.build(path=nil)
      file = self.instance

      # Should this logic be in the Settings.build method?
      if ::File.directory?(path)
        file.directory = path
      else
        file.directory = ::File.dirname(path)
        file.name = ::File.basename(path)
      end

      filepath = Pathname.new file.pathname
      self.validate(filepath)
      filepath
    end

    def self.validate(filepath)
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
