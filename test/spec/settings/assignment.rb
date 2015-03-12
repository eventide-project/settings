class SomeObject
  attr_reader :some_other_setting
end

describe Settings, "assignment" do
  specify "Configure an instance of an object by applying settings to it" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), "settings.json")
    settings = Settings.build(settings_file)

    some_obj = SomeObject.new
    settings.configure some_obj

    expect(some_obj.some_other_setting == "some other value")
  end
end
