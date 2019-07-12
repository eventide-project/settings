class Settings
  module Controls
    module DataSource
      module Hash
        def self.example
          ::Settings::DataSource::Hash.build(data)
        end

        def self.data
          Data::Flat::Single.example
        end
      end

      module Implementer
        def self.example
          Example.build
        end

        class Example < Settings
          def self.data_source
            DataSource::Hash.data
          end
        end
      end
    end
  end
end
