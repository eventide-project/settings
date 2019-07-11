class Settings
  module Keys
    module AssureSymbols
      def self.call(data)
        new_data = {}

        data.each do |key, value|
          new_key = key.to_sym

          if value.is_a?(Hash)
            new_value = AssureSymbols.(value)
          else
            new_value = value
          end

          new_data[new_key] = new_value
        end

        new_data
      end
    end
  end
end
