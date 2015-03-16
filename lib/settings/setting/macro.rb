class Settings
  module Setting
    module Macro
      def setting_macro(attr_name)
        Attribute::Define.! self, attr_name, :accessor
      end
      alias :setting :setting_macro
    end
  end
end
