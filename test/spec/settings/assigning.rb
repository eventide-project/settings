class SomeObject
  extend Settings::Setting::Macro

  setting :some_setting
  setting :some_other_setting
  setting :some_nested_setting
  setting :setting_not_in_the_data
  attr_accessor :some_attribute
end

describe Settings, "assignment" do
  specify "Set an object" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj

    expect(some_obj.some_setting.to_h == Hash[{ :some_nested_setting => { :another_nested_setting => "some nested value" }}] ).to be
    expect(some_obj.some_other_setting == "some other value").to be true
  end

  specify "Set an attribute explicitly" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj, attribute: :some_other_setting

    expect(some_obj.some_setting.nil?).to be true
    expect(some_obj.some_other_setting == "some other value").to be true
  end

  specify "Set an attribute explicitly from a nested namespace" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set(some_obj, "some_setting", attribute: :some_nested_setting)

    expect(some_obj.some_nested_setting.to_h == Hash[{ :another_nested_setting => "some nested value" }]).to be
  end

  specify "A setting that is not in the settings data is not set" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj

    expect(some_obj.setting_not_in_the_data.nil?).to be true
  end

  specify "An attribute that is not a setting does not get set" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.set some_obj

    expect(some_obj.some_attribute.nil?).to be true
  end

  specify "Strictly setting an attribute that isn't a defined setting is an error" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new

    expect { settings.set some_obj, attribute: :some_attribute }.to raise_error
  end

  specify "Unstrictly setting an attribute that isn't a defined setting is not an error" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new

    expect { settings.set some_obj, attribute: :some_attribute, strict: false }.to_not raise_error
  end

end
