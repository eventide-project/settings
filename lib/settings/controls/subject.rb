class Settings
  module Controls
    module Subject
      class Example
        setting :some_setting
        setting :some_other_setting
        setting :yet_another_setting
        attr_reader :some_reader_attribute
        attr_accessor :some_accessor_attribute
      end

      def self.example
        Example.new
      end
    end
  end
end
