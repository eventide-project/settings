override_data = {
  "some_setting" => {
    "some_nested_setting" => {
      "another_nested_setting" => "some other nested value",
      "yet_another_nested_setting" => "yet another nested value"
    }
  }
}

describe Settings, "overriden setting" do
  context "Settings are replaced by overridden settings" do
    specify "A setting that is in the settings data" do
      settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
      settings = Settings.build(settings_file)

      settings.override(override_data)

      another_nested_setting = settings.get('some_setting', 'some_nested_setting', 'another_nested_setting')

      expect(another_nested_setting == "some other nested value").to be
    end

    specify "A setting that is not in the settings data" do
      settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json")
      settings = Settings.build(settings_file)

      settings.override(override_data)

      yet_another_nested_setting = settings.get(['some_setting', 'some_nested_setting', 'yet_another_nested_setting'])

      expect(yet_another_nested_setting == "yet another nested value").to be
    end
  end
end
