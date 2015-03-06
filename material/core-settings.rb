module Core
  class Settings
    Logger.register self

    dependency :logger, Logger

    def self.logger
      Logger.get self
    end

    attr_reader :data
    attr_reader :logical_namespace
    attr_reader :physical_namespace

    def initialize(data, logical_namespace, physical_namespace=nil)
      physical_namespace ||= logical_namespace
      @data = data
      @logical_namespace = logical_namespace
      @physical_namespace = physical_namespace
    end

    def self.build(logical_namespace, settings_file=nil)
      logger.trace "Building settings accessor (Logical Namespace: #{logical_namespace})"

      all_data = load(settings_file)

      logger.trace "Getting physical namespace for logical namespace \"#{logical_namespace}\""
      physical_namespace = PhysicalNamespace.get logical_namespace
      logger.debug "Got physical namespace \"#{physical_namespace}\" for logical namespace \"#{logical_namespace}\""

      data = get_data(physical_namespace, all_data)

      instance = new(data, logical_namespace, physical_namespace).tap do |instance|
        Logger.configure instance
        logger.debug "Built settings accessor (Logical Namespace: #{logical_namespace}, Physical Namespace: #{physical_namespace})"
      end
    end

    def self.get_data(namespace, all_data)
      logger.trace "Getting data for namespace \"#{namespace}\""
      all_data.fetch(namespace).tap do |data|
        if data
          logger.debug "Got data for namespace \"#{namespace}\""
        else
          logger.warn "No data for namespace \"#{namespace}\""
        end
      end
    end

    def self.load(settings_file=nil)
      settings_file ||= File.canonical(settings_file)

      File.validate(settings_file)

      logger.trace "Opening settings file #{settings_file}"
      file = ::File.open(settings_file)
      logger.debug "Opened settings file #{settings_file}"

      logger.trace "Loading JSON data from #{settings_file}"
      JSON.load(file).tap do |data|
        logger.debug "Loaded JSON data from #{settings_file}"
      end
    end

    def get(key)
      # TODO The config data (config.json) isn't namespaced yet [Scott, Mon Feb 15 2015]
      # Ignore the key until the data is namespaced, eg: data['database']
      # For now, return the data

      logger.trace "Getting setting for key \"#{key}\" (Logical Namespace: #{logical_namespace}, Physical Namespace: #{physical_namespace})"
      data.tap do |setting|
        if setting
          logger.debug "Got setting for key \"#{key}\" (Logical Namespace: #{logical_namespace}, Physical Namespace: #{physical_namespace})"
        else
          logger.warn "No setting for key \"#{key}\" (Logical Namespace: #{logical_namespace}, Physical Namespace: #{physical_namespace})"
        end
      end
    end

    module File
      Logger.register self

      def self.logger
        Logger.get self
      end

      def self.canonical(settings_file=nil)
        logger.trace "Canonizing the settings filepath"

        settings_file ||= Defaults.file

        pn = Pathname.new settings_file

        pn.expand_path.tap do |filepath|
          logger.debug "Canonized the settings filepath \"#{filepath}\""
        end
      end

      def self.validate(file)
        logger.trace "Validating pathname \"#{file}\""
        pn = Pathname.new file

        unless pn.file?
          raise "Settings cannot be read from #{pn}. The file doesn't exist."
        end

        logger.debug "Validated pathname \"#{file}\""

        file
      end

      module Defaults
        Logger.register self

        def self.logger
          Logger.get self
        end

        def self.file
          settings_file = ENV['SETTINGS_FILE']

          if settings_file
            logger.debug "Using the settings file specified by the SETTINGS_FILE environment variable (#{settings_file})"
          else
            settings_file = 'config.json'
            logger.debug "Using the default settings file (#{settings_file})"
          end

          settings_file
        end
      end
    end

    module PhysicalNamespace
      def self.get(logical_namespace)

        return 'mongo' if logical_namespace == 'mongo_persistor'

        return 'warehouse_db' if logical_namespace == 'data_warehouse'
        return 'warehouse_db' if logical_namespace == 'warehouse'
        return 'warehouse_db' if logical_namespace == 'trade_aggregator'
        return 'warehouse_db' if logical_namespace == 'markets'
        return 'warehouse_db' if logical_namespace == 'reset_trading'

        return 'orders_db' if logical_namespace == 'orders'

        return 'accounts_db' if logical_namespace == 'accounts'

        return 'matching_engine' if logical_namespace == 'matching_engine'

        return logical_namespace
      end
    end
  end
end
