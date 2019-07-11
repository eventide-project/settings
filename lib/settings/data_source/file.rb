class Settings
  class DataSource
    class File < DataSource
      def self.canonize(source)
        logger.trace { "Canonizing the file source (Source: #{source})" }

        canonized_filepath = canonize_filepath(source)
        validate(canonized_filepath)

        logger.debug { "Canonized the file source (Source: #{source}, Canonized: #{canonized_filepath})" }

        canonized_filepath
      end

      def self.canonize_filepath(source)
        return default_filepath if source.nil?
        return source if full_path?(source)

        dirpath = nil
        filepath = nil

        if file?(source)
          dirpath = Pathname.new(Directory::Defaults.pathname)
        else
          filepath = Pathname.new(Defaults.filename)
        end

        dirpath ||= Pathname.new(source)
        filepath ||= Pathname.new(source)

        logger.debug { "Canonized the file source (#{source})" }

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
        logger.trace { "Validating the pathname (#{pathname})" }

        pathname = Pathname.new(pathname)

        unless pathname.file?
          msg = "Settings cannot be read from #{pathname}. The file doesn't exist."
          logger.error { msg }
          raise Settings::Error, msg
        end

        logger.trace { "Validated the pathname (#{pathname})" }
      end

      def self.logger
        @logger ||= Log.get(self)
      end

      def get_data
        logger.trace { "Reading file: #{source}" }
        file = ::File.open(source)
        data = JSON.load(file).tap do
          logger.debug { "Read file: #{source}" }
        end

        hash_data_source = Hash.build data
        hash_data_source.get_data
      end

      module Defaults
        def self.logger
          @logger ||= Log.get(self)
        end

        def self.filename
          default_file = 'settings.json'
          logger.debug { "Using the default settings file name (#{default_file})" }
          default_file
        end
      end

      module Directory
        module Defaults
          def self.logger
            @logger ||= Log.get(self)
          end

          def self.pathname
            default_dir = Dir.pwd
            logger.debug { "Using the working directory default settings directory (#{default_dir})" }
            default_dir
          end
        end
      end
    end
  end
end
