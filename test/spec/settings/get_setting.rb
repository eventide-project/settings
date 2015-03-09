data = {
  "some_setting" => "some value"
}

settings = Settings.new data

describe Settings do
  specify "Getting a setting from the setting data gets the setting's value" do
    key = 'some_setting'
    setting = settings.get key

    expect(setting == 'some value').to be
  end

  specify "Trying to get a setting that isn't in the data gets a nil" do
    key = 'setting_that_isnt_in_the_data'
    setting = settings.get key

    expect(setting == nil).to be
  end
end
