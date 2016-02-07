require_relative './bench_init'

context Settings::Registry do
  test "A registered setting is be stored in the settings registry by its class name" do
    Settings::Registry.register(Object, :some_setting)
    assert(Settings::Registry.setting?(Object, :some_setting))
  end

  test "An unregistered setting will not be stored in the settings registry" do
    assert(!Settings::Registry.setting?(Object, :some_other_setting))
  end
end
