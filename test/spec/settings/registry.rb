describe Settings::Registry do
  specify "A registered setting is be stored in the settings registry by its class name" do
    registry = Settings::Registry.new

    Settings::Registry.register(Object, :some_setting)

    expect(Settings::Registry.setting? Object, :some_setting ).to be true
  end

  specify "An unregistered setting will not be stored in the settings registry" do
    expect(Settings::Registry.setting? Object, :some_other_setting ).to_not be true
  end
end
