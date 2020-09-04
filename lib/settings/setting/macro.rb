class Settings
  module Setting
    module Macro
      def setting_macro(attribute)
        Attribute::Define.(self, attribute, :accessor)
        Settings::Registry.register(self, attribute)
      end
      alias :setting :setting_macro
    end
  end
end
