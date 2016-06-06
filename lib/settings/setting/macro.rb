class Settings
  module Setting
    module Macro
      def setting_macro(attribute)
        # logger = ::Telemetry::Logger.get self
        logger = SubstAttr::Substitute.build(::Telemetry::Logger)

        logger.opt_trace "Defining setting attribute: #{attribute}"
        Attribute::Define.(self, attribute, :accessor)
        Settings::Registry.register(self, attribute).tap do
          logger.opt_debug "Defined setting attribute: #{attribute}"
        end
      end
      alias :setting :setting_macro
    end
  end
end
