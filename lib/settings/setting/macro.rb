class Settings
  module Setting
    module Macro
      def setting_macro(attr_name)
        Attribute::Define.! self, attr_name, :accessor
        # TODO Register the class and setting name
        # Settings::Registry.register self, attr_name
      end
      alias :setting :setting_macro
    end
  end
end
