class Settings
  def self.activate(target_class=nil)
    target_class ||= Object

    macro_module = Settings::Setting::Macro

    return if target_class.is_a? macro_module

    logger = ::Telemetry::Logger.get self

    logger.opt_trace "Activating the Settings macro"
    target_class.extend(macro_module).tap do
      logger.opt_debug "Activated the Settings macro"
    end
  end
end
