require_relative './automated_init'

context "Registry" do
  context "Registered Setting" do
    Settings::Registry.register(Object, :some_setting)

    test "Is stored stored in the settings registry by its class name" do
      assert(Settings::Registry.setting?(Object, :some_setting))
    end
  end

  context "Unregistered Setting" do
    test "Is not stored in the settings registry" do
      refute(Settings::Registry.setting?(Object, :some_other_setting))
    end
  end
end
