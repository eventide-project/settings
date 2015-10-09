class Settings
  module Setting
    module Macro
      def setting_macro(attribute)
        logger = ::Telemetry::Logger.get self
        logger.trace "Defining setting attribute: #{attribute}"
        Attribute::Define.(self, attribute, :accessor)
        Settings::Registry.register(self, attribute).tap do
          logger.debug "Defined setting attribute: #{attribute}"
        end
      end
      alias :setting :setting_macro
    end
  end
end
