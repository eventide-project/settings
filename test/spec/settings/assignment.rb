class SomeObject
  attr_accessor :some_other_setting
end

describe Settings, "assignment" do
  specify "Configure an instance of an object by applying relevant settings to it" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.configure some_obj

    expect{some_obj.some_setting}.to raise_error(NoMethodError)
    expect(some_obj.some_other_setting == "some other value").to be
  end

  specify "Configure an instance of an object by applying one specified setting to it" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.configure some_obj, "some_other_setting"

    expect(some_obj.some_other_setting == "some other value").to be
  end
end
