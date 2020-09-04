class Settings
  class DataSource
    class Hash < DataSource
      def get_data
        AssureStringKeys.(source)
      end

      module AssureStringKeys
        def self.call(data)
          new_data = {}

          data.each do |key, value|
            new_key = key.to_s

            if value.is_a?(::Hash)
              new_value = self.(value)
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
end
