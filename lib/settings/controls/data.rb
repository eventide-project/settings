class Settings
  module Controls
    module Data
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
