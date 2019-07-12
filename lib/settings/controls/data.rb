class Settings
  module Controls
    module Data
      module Flat
        module Single
          def self.example
            {
              'some_setting' => 'some value'
            }
          end
        end

        module Multiple
          def self.example
            {
              'some_setting' => 'some value',
              'some_other_setting' => 'some other value',
            }
          end
        end
      end

      module Hierarchical
        def self.example
          {
            'some_namespace' => {
              'some_setting' => 'some value'
            }
          }
        end
      end

      module CamelCaseKeys
        def self.example
          {
            'someNamespace' => {
              'someSetting' => 'some value'
            }
          }
        end
      end
    end
  end
end
