class Settings
  module Setting
    module Assignment
      def self.assign(receiver, attr_name, value)
        return unless setting? receiver, attr_name
        return unless assignable? receiver, attr_name

        assign_value(receiver, attr_name, value)
        receiver
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
