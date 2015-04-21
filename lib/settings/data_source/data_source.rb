class Settings
  module DataSource
    def self.build(input)
      logger = Telemetry::Logger.get self
      logger.trace "Building (Data Source Type: #{input.class.name})"

      source = nil
      source = Settings::DataSource::Hash.build(input) if input.is_a?(::Hash)

      raise "Data source is not supported: #{input}" unless source

      logger.debug "Built (#{source})"

      source
    end
  end
end
