class Settings
  module DataSource
    class File
      dependency :logger, Telemetry::Logger

      attr_reader :source

      def initialize(source)
        @source = source
      end

      def self.build(source=nil)
        logger = Telemetry::Logger.get self

        logger.trace "Building"

        new(source).tap do |instance|
          Telemetry::Logger.configure instance
          logger.debug "Built"
        end
      end

      def canonical
        dirpath = nil
        filepath = nil

        unless source.nil?
          if ::File.extname(source) == ""
            dirpath = Pathname.new(source)
            filepath = Pathname.new(Defaults.filename)
          end
        end

        if source.nil?
          dirpath = Pathname.new(Directory::Defaults.pathname)
          filepath = Pathname.new(Defaults.filename)
        else
          if ::File.dirname(source) == "."
            dirpath = Pathname.new(Directory::Defaults.pathname)
            filepath = Pathname.new(source)
          end
        end

        (dirpath + filepath).to_s
      end

      module Defaults
        def self.logger
          @logger ||= ::Telemetry::Logger.get self
        end

        def self.filename
          default_file = 'settings.json' # .tap
          logger.debug "Using the default settings file name (#{default_file})"
          default_file
        end
      end

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
  end
end
