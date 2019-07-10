class Settings
  class DataSource
    class Hash < DataSource
      def self.logger
        @logger ||= Log.get(self)
      end

      def self.build(source)
        new(source)
      end

      def get_data
        source
      end
    end
  end
end
