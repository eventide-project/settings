require_relative './automated_init'

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

context "Get a setting from a file" do
  test "Retrieves the data from the file" do
    setting = GetSettingFromFile.get 'some_setting'
    assert(setting == 'some value')
  end
end
