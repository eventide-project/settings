class Settings
  class Registry
    attr_accessor :data

    def initialize
      @data = {}
    end

    def register(cls, attr_name)
      unless setting?(cls, attr_name)
        registered?(cls) ? @data[cls].push(attr_name) : @data[cls] = [attr_name]
      end

      @data[cls]
    end

    def setting?(cls, attr_name)
      registered?(cls) ? @data[cls].include?(attr_name) : false
    end

    def registered?(cls)
      !!@data[cls]
    end

    class << self
      def instance
        @instance ||= new
      end

      def register(cls, attr_name)
        instance.register(cls, attr_name)
      end

      def setting?(cls, attr_name)
        instance.setting?(cls, attr_name)
      end
    end
  end
end
