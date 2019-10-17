require_relative '../../automated_init'

context "Set" do
  context "Setting" do
    context "Corresponding Attributes" do
      example = Controls::Subject.example

      settings = Controls::Settings::SettingAttribute.example

      settings.set(example, attribute: :some_setting)

      test "Assigns data to the attributes" do
        assert(example.some_setting == "some value")
      end
    end

    context "Attribute that Doesn't Correspond" do
      example = Controls::Subject.example

      settings = Controls::Settings::SettingAttribute.example

      random_attribute_name = SecureRandom.hex.to_sym

      test "Is an error" do
        assert_raises(Settings::Error) do
          settings.set(example, attribute: random_attribute_name)
        end
      end
    end
  end
end
