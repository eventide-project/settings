class Settings
  class DataSource
    include Log::Dependency

    attr_reader :source

    def initialize(source)
      @source = source
    end
  end
end
