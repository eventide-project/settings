module GetNestedSetting
  def self.data
    {
      "some_setting" => {
        "some_nested_setting" => {
          "another_nested_setting" => "some nested value"
        }
      }
    }
  end

  def self.settings
    Settings.new data
  end

  def self.get(*key)
    settings.get key
  end
end

describe "Get Nested Setting" do
  specify "Getting a nested setting from the setting data gets the setting's value and descendant values" do
    setting = GetNestedSetting.get 'some_setting', 'some_nested_setting'
    assert(setting == Hash[ "another_nested_setting" => "some nested value" ])
  end
end
