module GetSettingFromFile
  def self.settings_file
    File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
  end

  def self.settings
    Settings.build(settings_file)
  end

  def self.get(key)
    settings.get key
  end
end

describe "Get a setting from a file", :* do
  specify "Retrieves the data from the file" do
    setting = GetSettingFromFile.get 'some_setting'
    assert(setting == 'some value')
  end
end
