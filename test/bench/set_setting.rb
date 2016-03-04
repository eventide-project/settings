require_relative './bench_init'

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

context "Set a setting attribute" do
  test "Assigns the data to the corresponding attribute" do
    example = SetSetting.example
    SetSetting.settings.set example, attribute: :some_setting

    assert(example.some_setting == "some value")
  end

  test "When there's no corresponding data, it's an error" do
    example = SetSetting.example

    assign_attribute_not_in_data = -> do
      SetSetting.settings.set example, attribute: :not_in_the_data
    end

    assert assign_attribute_not_in_data do
      raises_error? Settings::Error
    end
  end
end
