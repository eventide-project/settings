class Settings
  class DataSource
    class Env < DataSource
      def get_data
        source.map do |k, v|
          [k.downcase, v]
        end.to_h
      end
    end
  end
end
