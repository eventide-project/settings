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

      def self.setting?(receiver, attr_name)
        # ...
        # Registry.instance.setting? receiver, attr_name
      end

      def self.assignable?(receiver, attr_name)
        receiver.respond_to? setter_name(attr_name)
      end

      def self.setter_name(attr_name)
        :"#{attr_name}=" unless attr_name.to_s.end_with '='
      end
    end
  end
end
