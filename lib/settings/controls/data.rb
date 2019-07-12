class Settings
  module Controls
    module Data
      module CamelCaseKeys
        def self.example
          {
            'someNamespace' => {
              'someSetting' => 'some value'
            }
          }
        end
      end

      module StringKeys
        def self.example
          {
            'some_namespace' => {
              'some_setting' => 'some value'
            }
          }
        end
      end
    end
  end
end
