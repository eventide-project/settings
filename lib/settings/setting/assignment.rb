class Settings
  module Setting
    module Assignment
      extend self

      def assign(receiver, attribute, value, strict=false)
        settable = assure_settable(receiver, attribute, strict)
        if settable
          assign_value(receiver, attribute, value)
        end

        receiver
      end

      def assign_value(receiver, attribute, value)
        receiver.public_send("#{attribute}=", value)
      end

      def setting?(receiver, attribute)
        receiver_class = receiver.class
        Settings::Registry.instance.setting? receiver_class, attribute
      end

      def assignable?(receiver, attribute)
        receiver.respond_to? setter_name(attribute)
      end

      def setter_name(attribute)
        :"#{attribute.to_s}=" unless attribute.to_s.end_with? '='
      end

      module Object
        extend Assignment

        def self.assure_settable(receiver, attribute, strict=true)
          if strict
            setting = setting?(receiver, attribute)
            unless setting
              return false
            end
          end

          assignable = assignable? receiver, attribute
          unless assignable
            return false
          end

          true
        end
      end

      module Attribute
        extend Assignment

        def self.assure_settable(receiver, attribute, strict=true)
          if strict
            setting = setting? receiver, attribute
            unless setting
              raise "Can't set \"#{attribute}\". It isn't a setting of #{receiver.class.name}."
            end
          end

          assignable = assignable?(receiver, attribute)
          unless assignable
            raise "Can't set \"#{attribute}\". It isn't assignable to #{receiver.class.name}."
          end

          true
        end
      end
    end
  end
end
