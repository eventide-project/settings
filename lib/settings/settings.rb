require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(pathname=nil)
    # Does this need to be tested again? Is it even necessary?
    pathname ||= File.instance.pathname

    file_data = ::File.open(pathname)

    data = JSON.load file_data

    new data
  end

  def get(*key)
  	key.flatten! if key.is_a? Array
  	key.inject(data) {|memo, k| memo[k] }
  end

  class File
    # Is there a use for setting directory/name separately versus together?
    attr_accessor :directory
    attr_accessor :name

    def self.instance
      @instance ||= new
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
