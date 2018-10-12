require_relative '../automated_init'

context "Get Setting" do
  settings = Controls::Settings::SettingAttribute.example

  context "Setting is in the data" do
    value = settings.get('some_setting')

    test "Gets the setting's value" do
      assert(value == 'some value')
    end
  end

  context "Setting isn't in the data" do
    random_setting_name = SecureRandom.hex

    value = settings.get(random_setting_name)

    test "Gets nil" do
      assert(value == nil)
    end
  end
end
