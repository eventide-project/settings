class Settings
  class Registry
    def data
      @data ||= {}
    end
    attr_writer :data

    def register(cls, attribute)
      unless setting?(cls, attribute)
        registered?(cls) ? @data[cls].push(attribute) : @data[cls] = [attribute]
      end

      data[cls]
    end

    def setting?(cls, attribute)
      registered?(cls) ? data[cls].include?(attribute) : false
    end

    def registered?(cls)
      !!data[cls]
    end

    class << self
      def instance
        @instance ||= new
      end

      def register(cls, attribute)
        instance.register(cls, attribute)
      end

      def setting?(cls, attribute)
        instance.setting?(cls, attribute)
      end
    end
  end
end
