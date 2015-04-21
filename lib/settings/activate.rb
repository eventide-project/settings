class Settings
  def self.activate(target_class=nil)
    target_class ||= Object

    macro_module = Settings::Setting::Macro

    return if target_class.ancestors.include? macro_module

    logger = ::Telemetry::Logger.get self

    logger.trace "Activating the Settings macro"
    target_class.extend(macro_module).tap do
      logger.debug "Activated the Settings macro"
    end
  end
end
