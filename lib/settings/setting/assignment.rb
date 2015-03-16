class Settings
  module Setting
    module Assignment
      # maybe just procedures, ie: all 'self' maybe

      def self.assign(receiver, key)
        # ...
        # setting? ...
        # assignable? ...
        # assign_value ...
        # return value
      end

      def self.assign_value(receiver, setting_name, value)
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
