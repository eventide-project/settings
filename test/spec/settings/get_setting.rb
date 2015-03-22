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

describe "Get Settings", :* do
  specify "Getting a setting from the setting data gets the setting's value" do
    setting = GetSetting.get 'some_setting'
    expect(setting == 'some value').to be
  end

  specify "Trying to get a setting that isn't in the data gets a nil" do
    setting = GetSetting.get 'setting_that_isnt_in_the_data'
    expect(setting == nil).to be
  end
end
