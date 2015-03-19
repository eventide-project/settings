class Settings
  module Setting
    module Assignment
      Logger.register self

      def self.logger
        Logger.get self
      end

      def self.assign(receiver, attr_name, value, strict=false)
        if validate_attribute(receiver, attr_name, strict)
          assign_value(receiver, attr_name, value)
        end

        receiver
      end

      def self.validate_attribute(receiver, attr_name, strict)
        setting = setting? receiver, attr_name
        assignable = assignable? receiver, attr_name

        valid = true

        unless setting
          msg = "Can't set \"#{attr_name}\". It isn't a setting of #{receiver}."
          if strict
            logger.error msg
            raise msg
          else
            logger.warn msg
            valid = false
          end
        end

        unless setting
          msg = "Can't set \"#{attr_name}\". It isn't assignable to #{receiver}."
          if strict
            logger.error msg
            raise msg
          else
            logger.warn msg
            valid = false
          end
        end

        valid
      end

      def self.assign_value(receiver, attr_name, value)
        receiver.send "#{attr_name}=", value
        value
      end

      def self.setting?(receiver, attr_name)
        receiver_class = receiver.class
        Settings::Registry.instance.setting? receiver_class, attr_name
      end

      def self.assignable?(receiver, attr_name)
        receiver.respond_to? setter_name(attr_name)
      end

      def self.setter_name(attr_name)
        :"#{attr_name.to_s}=" unless attr_name.to_s.end_with? '='
      end
    end
  end
end
