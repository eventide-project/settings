class Settings
  module File
    def self.logger
      @logger ||= Logger.get self
    end

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
        msg = "Settings cannot be read from #{pathname}. The file doesn't exist."
        logger.error msg
        raise msg
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
        @logger ||= Logger.get self
      end

      def self.filename
        default_file = 'settings.json'
        logger.debug "Using the default settings file name (#{default_file})"
        default_file
      end
    end
  end
end
