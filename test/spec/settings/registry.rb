describe Settings::Registry, :* do
  specify "A registered setting will be stored in the settings registry by its class name" do
    registry = Settings::Registry.instance

    registry.register(Object, :some_setting)

    expect(registry.setting? Object, :some_setting ).to be true
  end

  specify "An unregistered setting will not be stored in the settings registry" do
    registry = Settings::Registry.instance

    expect(registry.setting? Object, :some_other_setting ).to_not be true
  end
end
