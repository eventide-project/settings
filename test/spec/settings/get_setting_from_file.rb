module GetSettingFromFile
  def self.settings_file
    File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
  end

  def self.settings
    Settings.build(settings_file)
  end

  def self.get(key)
    settings.get key
  end
end

describe "Getting a setting from a file", :* do
  specify "Getting a setting from a file" do
    setting = GetSettingFromFile.get 'some_setting'
    assert(setting == 'some value')
  end
end
