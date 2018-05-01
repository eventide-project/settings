require_relative '../automated_init'

module SetSetting
  def self.data
    {
      "some_setting" => "some value"
    }
  end

  def self.settings
    Settings.build(data)
  end

  def self.example
    Example.new
  end

  class Example
    setting :some_setting
    setting :not_in_the_data
  end
end

context "Set" do
  context "Setting" do
    context "Corresponding Attributes" do
      example = SetSetting.example

      SetSetting.settings.set(example, attribute: :some_setting)

      test "Assigns data to the attributes" do
        assert(example.some_setting == "some value")
      end
    end

    context "Attributes that Don't Correspond" do
      example = SetSetting.example

      assign_attribute_not_in_data = proc do
        SetSetting.settings.set(example, attribute: :not_in_the_data)
      end

      test "Is an error" do
        assert assign_attribute_not_in_data do
          raises_error? Settings::Error
        end
      end
    end
  end
end
