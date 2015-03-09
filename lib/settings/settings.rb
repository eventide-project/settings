require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(pathname=nil)
    # QUESTION Does this need to be tested again with the nil case since the File defaults have already been tested?
    # Should the pathname even be optional?
    pathname ||= File.instance.pathname

    File.validate(pathname)

    file_data = ::File.open(pathname)

    data = JSON.load file_data

    new data
  end

  def get(*key)
  	key.flatten! if key.is_a? Array
  	key.inject(data) {|memo, k| memo[k] }
  end

  class File
    # QUESTION Is there a use case for setting directory/name separately versus together?
    attr_accessor :directory
    attr_accessor :name

    def self.instance
      @instance ||= new
    end

    def self.validate(file)
      pathname = Pathname.new file

      unless pathname.file?
        raise "Settings cannot be read from #{pathname}. The file doesn't exist."
      end
    end

    def pathname
      directory = Pathname.new (self.directory ||= Defaults.directory).to_s
      name = Pathname.new (self.name ||= Defaults.name).to_s

      pathname = (directory + name).to_s
    end

    module Defaults
      def self.name
        'settings.json'
      end

      # QUESTION Is there a better way to set the default path?
      def self.directory
        ENV['SETTINGS_FILE']
      end
    end
  end

  # class File
  #   attr_accessor :directory

  #   def self.instance
  #     @instance ||= new
  #   end

  #   def pathname
  #     directory = Pathname.new self.directory.to_s
  #     name = Pathname.new Defaults.name

  #     pathname = (directory + name).to_s
  #   end

  #   module Defaults
  #     def self.name
  #       'settings.json'
  #     end
  #   end
  # end
end
