class Settings
  class DataSource
    class Hash < DataSource
      def self.build(source)
        logger = Telemetry::Logger.get self

        logger.opt_trace "Building"

        new(source).tap do |instance|
          # Telemetry::Logger.configure instance
          logger.opt_debug "Built"
        end
      end

      def get_data
        logger.opt_trace "Converting the raw source data to Confstruct"
        Confstruct::Configuration.new(source).tap do |instance|
          logger.opt_debug "Converted the raw source data to Confstruct"
        end
      end
    end
  end
end
