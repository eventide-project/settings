class Settings
  class Registry
    attr_accessor :data

    def self.instance
      @instance ||= new
    end

    def initialize
      @data = {}
    end

    def register(cls, attr_name)
      return if setting?(cls, attr_name)

      @data[cls] ? @data[cls].push(attr_name) : @data[cls] = [attr_name]
    end

    def setting?(cls, attr_name)
      @data[cls] ? @data[cls].include?(attr_name) : false
    end
  end
end
