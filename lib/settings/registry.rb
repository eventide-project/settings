class Settings
  class Registry
    def register(cls, attr_name)
      # ...
      # { Thing => [:foo] }
    end

    def setting?(cls, attr_name)
    end

    def self.instance
      @instance ||= new
    end
  end
end
