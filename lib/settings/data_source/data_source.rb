class Settings
  class DataSource
    dependency :logger, Telemetry::Logger

    attr_reader :source

    def initialize(source)
      @source = source
    end
  end
end
