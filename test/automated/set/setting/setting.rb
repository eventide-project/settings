require_relative '../../automated_init'

context "Set" do
  context "Setting" do
    context "Corresponding Attributes" do
      example = Settings::Controls::Subject.example

      settings = Settings::Controls::Settings::SettingAttribute.example

      settings.set(example, attribute: :some_setting)

      test "Assigns data to the attributes" do
        assert(example.some_setting == "some value")
      end
    end

    context "Attribute that Doesn't Correspond" do
      example = Settings::Controls::Subject.example

      settings = Settings::Controls::Settings::SettingAttribute.example

      random_attribute_name = SecureRandom.hex.to_sym

      assign_attribute_not_in_source = proc do
        settings.set(example, attribute: random_attribute_name)
      end

      test "Is an error" do
        assert assign_attribute_not_in_source do
          raises_error? Settings::Error
        end
      end
    end
  end
end
