describe "Getting a setting from a file" do
  specify "Getting a setting from a file" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
    settings = Settings.build(settings_file)

    setting = settings.get 'some_setting'

    assert(setting == 'some value')
  end
end
