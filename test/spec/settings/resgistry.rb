class SomeObject
  setting :some_setting
  setting :some_other_setting
end

describe Settings::Registry do
  specify "A registered setting will be stored in the settings registry by its class name" do
    registry = Settings::Registry.instance

    registry.register(SomeObject, :some_setting)

    expect(registry.setting? SomeObject, :some_setting ).to be
  end

  specify "An unregistered setting will not be stored in the settings registry" do
    registry = Settings::Registry.instance

    expect(registry.setting? SomeObject, :some_other_setting ).to_not be
  end
end
