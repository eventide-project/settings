class SomeObject
  extend Settings::Setting::Macro

  setting :some_setting
  setting :some_other_setting
  setting :setting_not_in_the_data
  attr_accessor :some_attribute
end

describe Settings, "assignment" do
  specify "Configure an instance of an object by applying all settings to it" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj

    expect(some_obj.some_setting.to_h == Hash[{ :some_nested_setting => { :another_nested_setting => "some nested value" }}] ).to be
    expect(some_obj.some_other_setting == "some other value").to be
  end

  specify "Configure an instance of an object by applying one specified setting to it" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj, "some_other_setting"

    expect(some_obj.some_setting == nil).to be
    expect(some_obj.some_other_setting == "some other value").to be
  end

  specify "Configure an instance of an object by applying multiple settings to it" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj, ["some_other_setting", "some_setting"]

    expect(some_obj.some_setting.to_h == Hash[{ :some_nested_setting => { :another_nested_setting => "some nested value" }}]).to be
    expect(some_obj.some_other_setting == "some other value").to be
  end

  specify "Trying to configure a setting that is not in the settings data does not assign the setting value to the receiver" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj, "setting_not_in_the_data"

    expect(some_obj.setting_not_in_the_data == nil).to be
  end

  specify "An attribute that is not a setting does not get set" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj

    expect(some_obj.some_attribute).to eq nil
  end
end
