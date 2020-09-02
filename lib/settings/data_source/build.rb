class Settings
  class DataSource
    module Build
      def self.call(input=nil)
        data_source_type = type(input)
        data_source_type.build(input)
      end
      class << self; alias :! :call; end # TODO: Remove deprecated actuator [Kelsey, Thu Oct 08 2015]

      def self.type(input=nil)
        return Settings::DataSource::Hash if input.is_a?(::Hash)
        return Settings::DataSource::File if input.is_a?(String) || input.nil?
        return Settings::DataSource::Env if input.instance_of?(Object)

        raise Settings::Error, "Input is not supported: #{input}"
      end
    end
  end
end
