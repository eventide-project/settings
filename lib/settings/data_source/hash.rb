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
        logger.trace { "Converting the raw source data to Confstruct" }
        Confstruct::Configuration.new(source).tap do |instance|
          logger.debug { "Converted the raw source data to Confstruct" }
        end
      end
    end
  end
end
