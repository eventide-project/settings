class SomeObject
  extend Settings::Setting::Macro

  setting :some_setting
  attr_accessor :some_attribute
end

describe Settings::Registry do
  specify "A setting attribute will be stored in the registry" do
    registry = Settings::Registry.instance

    expect(registry.setting?(SomeObject, :some_setting)).to be
  end

  specify "A non-setting attribute will not be stored in the registry" do
    registry = Settings::Registry.instance

    expect(registry.setting?(SomeObject, :some_attribute) == false).to be
  end
end
