class Settings
  module DataSource
    class File
      dependency :logger, Telemetry::Logger

      attr_reader :source

      def initialize(source)
        @source = source
      end

      def self.build(source=nil)
        logger.trace "Building"

        canonical = canonical(source)
        validate(canonical)

        new(canonical).tap do |instance|
          Telemetry::Logger.configure instance
          logger.debug "Built"
        end
      end

      def self.canonical(source)
        logger.trace "Canonizing the file source (#{source})"

        canonize(source).tap do |instance|
          logger.debug "Canonized the file source (#{source})"
        end
      end

      def self.canonize(source)
        return default_filepath if source.nil?
        return source if full_path?(source)

        dirpath = Pathname.new(source)
        filepath = Pathname.new(source)

        if file?(source)
          dirpath = Pathname.new(Directory::Defaults.pathname)
        else
          filepath = Pathname.new(Defaults.filename)
        end

        pathname(filepath, dirpath)
      end

      def self.default_filepath
        dirpath = Pathname.new(Directory::Defaults.pathname)
        filepath = Pathname.new(Defaults.filename)

        pathname(filepath, dirpath)
      end

      def self.pathname(filepath, dirpath)
        (dirpath + filepath).to_s
      end

      def self.full_path?(source)
        file?(source) && dir?(source)
      end

      def self.file?(filepath)
        ::File.extname(filepath) != ""
      end

      def self.dir?(dirpath)
        ::File.dirname(dirpath) != "."
      end

      def self.validate(pathname)
        logger.trace "Validating the pathname (#{pathname})"

        pathname = Pathname.new(pathname)

        unless pathname.file?
          msg = "Settings cannot be read from #{pathname}. The file doesn't exist."
          logger.error msg
          raise msg
        end

        logger.trace "Validated the pathname (#{pathname})"
      end

      def self.logger
        @logger ||= ::Telemetry::Logger.get self
      end

      def get_data
        logger.trace "Reading file: #{source}"
        file = ::File.open(source)
        JSON.load(file).tap do
          logger.debug "Read file: #{source}"
        end
      end

      def self.read(pathname)
        logger.trace "Reading #{pathname}"
        file = ::File.open(pathname)
        JSON.load(file).tap do
          logger.debug "Read #{pathname}"
        end
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
