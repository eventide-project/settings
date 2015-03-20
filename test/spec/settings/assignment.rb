class AnotherObject
  extend Settings::Setting::Macro

  setting :some_setting
  setting :some_other_setting
  setting :setting_not_in_the_data
  attr_reader :some_attribute
end

describe Settings::Setting::Assignment do
  specify "Determine whether the attribute is a setting" do
    another_object = AnotherObject.new

    expect(Settings::Setting::Assignment.setting? another_object, :some_setting).to be
    expect(Settings::Setting::Assignment.setting? another_object, :some_attribute).to_not be
  end

  specify "Determine whether the attribute is assignable" do
    another_object = AnotherObject.new

    expect(Settings::Setting::Assignment.assignable? another_object, :some_setting).to be
    expect(Settings::Setting::Assignment.assignable? another_object, :some_attribute).to_not be
  end

  specify "Assign to the corresponding attribute on the receiver" do
    another_object = AnotherObject.new

    Settings::Setting::Assignment::Object.assign_value(another_object, :some_setting, "some value")

    expect(another_object.some_setting == "some value").to be
  end
end
