require_relative './automated_init'

module GetSettingArray
  def self.data
    {
      "some_setting" => [1, 11, 111]
    }
  end

  def self.settings
    Settings.new(data)
  end

  def self.get(key)
    settings.get(key)
  end
end

context "Get Settings" do
  test "Gets the setting's value" do
    setting = GetSettingArray.get('some_setting')
    assert(setting == [1, 11, 111])
  end

  test "Trying to get a setting that isn't in the data gets a nil" do
    setting = GetSettingArray.get('setting_that_isnt_in_the_data')
    assert(setting == nil)
  end
end
