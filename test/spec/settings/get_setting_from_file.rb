describe Settings do
  specify "Getting a setting from a file" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
    settings = Settings.build(settings_file)
    key = 'some_setting'
    setting = settings.get key

    expect(setting == 'some value').to be
  end

  specify "Trying to get a setting from a file that doesn't exist" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")

    # QUESTION Which one?
    # expect{Settings::File.validate(settings_file)}.to raise_error
    expect{Settings.build(settings_file)}.to raise_error
  end
end
