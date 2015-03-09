require 'json'

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(pathname)
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

    def self.instance
      @instance ||= new
    end

    def pathname
      directory = Pathname.new self.directory.to_s
      name = Pathname.new Defaults.name

      pathname = (directory + name).to_s
    end

    module Defaults
      def self.name
        'settings.json'
      end
    end
  end
end
