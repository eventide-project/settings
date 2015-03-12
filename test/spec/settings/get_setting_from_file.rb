describe Settings do
  # Pass in directory path
  specify "Getting a setting from the default filename given a directory path" do
    settings_directory = File.dirname(File.expand_path(__FILE__))
    settings = Settings.build(settings_directory)
    keys = ['some_setting', 'some_nested_setting']
    setting = settings.get keys

    expect(setting == 'some nested value').to be
  end

  # Pass in filepath
  specify "Getting a setting from a file given a filepath" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
    settings = Settings.build(settings_file)
    key = 'some_setting'
    setting = settings.get key

    expect(setting == 'some value').to be
  end

  specify "Trying to get a setting from a file that doesn't exist" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "file-that-does-not-exist.json")

    # QUESTION Which one?
    # expect{Settings::File.validate(settings_file)}.to raise_error
    expect{Settings.build(settings_file)}.to raise_error(Errno::ENOENT)
  end
end
