require_relative './spec_init'

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

describe "Set a setting attribute" do
  specify "Assigns the data to the corresponding attribute" do
    example = SetSetting.example
    SetSetting.settings.set example, attribute: :some_setting

    assert(example.some_setting == "some value")
  end

  specify "When there's no corresponding data, it's an error" do
    example = SetSetting.example

    assert_raises RuntimeError do
      SetSetting.settings.set example, attribute: :not_in_the_data
    end
  end
end
