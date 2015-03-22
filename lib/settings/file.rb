class Settings
  module File
    def self.canonical(pathname)
      if ::File.extname(pathname) == ""
        pathname = (Pathname.new(pathname) + Defaults.filename).to_s
      end

      if ::File.dirname(pathname) == "."
        pathname = (Pathname.new(Directory::Defaults.pathname) + pathname).to_s
      end

      pathname
    end

    def self.validate(pathname)
      pathname = Pathname.new pathname

      unless pathname.file?
        # TODO Log error [Scott, Sun Mar 22 2015]
        raise "Settings cannot be read from #{pathname}. The file doesn't exist."
      end
    end

    module Defaults
      def self.filename
        logger = Logger.get self
        default_file = 'settings.json'
        logger.debug "Using the default settings file name (#{default_file})"
        default_file
      end
    end
  end
end
