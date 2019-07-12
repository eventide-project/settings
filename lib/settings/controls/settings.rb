class Settings
  module Controls
    module Settings
      module SettingAttribute
        def self.example
          ::Settings.build(data)
        end

        def self.data
          Data::Flat::Single.example
        end
      end

      module PartialMatch
        def self.example
          ::Settings.build(data)
        end

        def self.data
          Data::Flat::Multiple.example
        end
      end

      module Namespace
        def self.example
          ::Settings.build(data)
        end

        def self.data
          Data::Hierarchical.example
        end
      end

      module AccessorAttribute
        def self.example
          ::Settings.build(data)
        end

        def self.data
          {
            'some_accessor_attribute' => 'some accessor value'
          }
        end
      end
    end
  end
end
