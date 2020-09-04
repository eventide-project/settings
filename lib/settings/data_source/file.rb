class Settings
  class DataSource
    class File < DataSource
      def self.canonize(source)
        canonized_filepath = canonize_filepath(source)
        validate(canonized_filepath)

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
        pathname = Pathname.new(pathname)

        unless pathname.file?
          raise Settings::Error, "Settings cannot be read from #{pathname}. The file doesn't exist."
        end
      end

      def get_data
        file = ::File.open(source)

        data = JSON.load(file)

        hash_data_source = Hash.build data
        hash_data_source.get_data
      end

      module Defaults
        def self.filename
          'settings.json'
        end
      end

      module Directory
        module Defaults
          def self.pathname
            Dir.pwd
          end
        end
      end
    end
  end
end
