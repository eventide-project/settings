class Settings
  module Directory
    module Defaults
      def self.pathname
        logger = ::Telemetry::Logger.get self
        default_dir = Dir.pwd
        logger.debug "Using the working directory default settings directory (#{default_dir})"
        default_dir
      end
    end
  end
end
