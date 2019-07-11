class Settings
  module Controls
    module Settings
      module SettingAttribute
        def self.example
          ::Settings.build(data)
        end

        def self.data
          {
            "some_setting" => "some value"
          }
        end
      end

      module SettingAttributes
        def self.example
          ::Settings.build(data)
        end

        def self.data
          {
            "some_setting" => "some value",
            "some_other_setting" => "some other value",
            "yet_another_setting" => "yet another value"
          }
        end

        module Partial
          def self.example
            ::Settings.build(data)
          end

          def self.data
            {
              "some_setting" => "some value",
              "some_other_setting" => "some other value",
            }
          end
        end
      end

      module AccessorAttribute
        def self.example
          ::Settings.build(data)
        end

        def self.data
          {
            "some_accessor_attribute" => "some accessor value"
          }
        end
      end

      module Namespace
        def self.example
          ::Settings.build(data)
        end

        def self.data
          {
            "some_namespace" => {
              "some_setting" => "some value"
            }
          }
        end
      end
    end
  end
end
