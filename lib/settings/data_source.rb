class Settings
  class DataSource
    attr_reader :source

    def initialize(source)
      @source = source
    end

    def self.build(source=nil)
      source = canonize(source) if respond_to? :canonize

      new(source)
    end
  end
end
