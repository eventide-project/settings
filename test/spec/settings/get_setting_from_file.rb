describe Settings do
  specify "Get a setting from a file" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
    settings = Settings.build(settings_file)
    key = 'some_setting'
    setting = settings.get key

    expect(setting == 'some value').to be
  end
end
