class Settings
  module Setting
    module Assignment
      extend self

      def logger
        Logger.get self
      end

      def assign(receiver, attr_name, value, strict=false)
        settable = assure_settable(receiver, attr_name, strict)
        if settable
          assign_value(receiver, attr_name, value)
        end

        receiver
      end

      def assign_value(receiver, attr_name, value)
        logger.trace "Assigning to #{attr_name}"
        receiver.send("#{attr_name}=", value).tap do
          logger.debug "Assigning to #{attr_name}"
          logger.data "Assigned #{value} to #{attr_name}"
        end
      end

      def setting?(receiver, attr_name)
        receiver_class = receiver.class
        Settings::Registry.instance.setting? receiver_class, attr_name
      end

      def assignable?(receiver, attr_name)
        receiver.respond_to? setter_name(attr_name)
      end

      def setter_name(attr_name)
        :"#{attr_name.to_s}=" unless attr_name.to_s.end_with? '='
      end

      def digest(receiver, attribute, strict)
        content = []
        content << "Attribute: #{attribute}" if attribute
        content << "Receiver: #{receiver}"
        strict = "<not set>" if strict.nil?
        content << "Strict: #{strict}"
        content.join ', '
      end

      module Object
        extend Assignment

        def logger
          Logger.get self
        end

        def self.assure_settable(receiver, attr_name, strict=true)
          logger.trace "Approving attribute (#{digest(receiver, attr_name, strict)})"

          if strict
            setting = setting?(receiver, attr_name)
            unless setting
              logger.debug "Can't set \"#{attr_name}\". It isn't a setting of #{receiver}."
              return false
            end
          end

          assignable = assignable? receiver, attr_name
          unless assignable
            logger.debug "Can't set \"#{attr_name}\". It isn't assignable to #{receiver}."
            return false
          end

          logger.debug "\"#{attr_name}\" can be set"
          true
        end
      end

      module Attribute
        extend Assignment

        def logger
          Logger.get self
        end

        def self.assure_settable(receiver, attr_name, strict=true)
          if strict
            setting = setting? receiver, attr_name
            unless setting
              msg = "Can't set \"#{attr_name}\". It isn't a setting of #{receiver}."
              logger.error msg
              raise msg
            end
          end

          assignable = assignable? receiver, attr_name
          unless assignable
            msg = "Can't set \"#{attr_name}\". It isn't assignable to #{receiver}."
            logger.error msg
            raise msg
          end

          logger.debug "\"#{attr_name}\" can be set"
          true
        end
      end
    end
  end
end
