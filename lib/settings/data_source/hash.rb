class Settings
  module DataSource
    class Hash
      attr_reader :data_source

      def initialize(data_source)
        @data_source = data_source
      end

      def self.build(data_source)
        new(data_source)
      end
    end
  end
end
