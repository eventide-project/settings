class Settings
  module Controls
    module Data
      module CamelCaseKeys
        def self.example
          {
            "someNamespace" => {
              "someSetting" => "some value"
            }
          }
        end
      end
    end
  end
end
