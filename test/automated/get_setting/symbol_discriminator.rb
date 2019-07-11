require_relative '../automated_init'

context "Get Setting" do
  context "Symbol Discriminator" do
    settings = Controls::Settings::SettingAttribute.example

    value = settings.get(:some_setting)

    test "Gets the setting's value" do
      assert(value == 'some value')
    end
  end
end
