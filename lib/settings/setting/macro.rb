class Settings
  module Setting
    module Macro
      def setting_macro(attr_name)
        logger = Logger.get self
        logger.trace "Defining setting attribute: #{attr_name}"
        Attribute::Define.! self, attr_name, :accessor
        Settings::Registry.register(self, attr_name).tap do
          logger.debug "Defined setting attribute: #{attr_name}"
        end
      end
      alias :setting :setting_macro
    end
  end
end
