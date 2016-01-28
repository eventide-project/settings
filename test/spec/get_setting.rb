require_relative './spec_init'

module GetSetting
  def self.data
    {
      "some_setting" => "some value"
    }
  end

  def self.settings
    Settings.new data
  end

  def self.get(key)
    settings.get key
  end
end

context "Get Settings" do
  test "Gets the setting's value" do
    setting = GetSetting.get 'some_setting'
    assert(setting == 'some value')
  end

  test "Trying to get a setting that isn't in the data gets a nil" do
    setting = GetSetting.get 'setting_that_isnt_in_the_data'
    assert(setting == nil)
  end
end
