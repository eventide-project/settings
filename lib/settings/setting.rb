class Settings
  module Setting
    def self.included(cls)
      cls.class_exec do
        extend Macro
      end
    end
  end
end
