class Settings
  class DataSource
    include Log::Dependency

    attr_reader :source

    def initialize(source)
      @source = source
    end

    ## something to make sure keys are symbols
  end
end
