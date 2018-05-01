require_relative '../automated_init'

context "Assignment" do
  context "Attribute" do
    context "Attribute is a Setting" do
      example = Settings::Controls::Subject.example

      settable = Settings::Setting::Assignment::Attribute.assure_settable(example, :some_setting)

      test "Settable when the attribute is a setting" do
        assert(settable)
      end
    end

    context "Strict" do
      example = Settings::Controls::Subject.example

      assign_plain_attribute_strict = proc do
        Settings::Setting::Assignment::Attribute.assure_settable(example, :some_acessor_attribute, strict = true)
      end

      test "Is an error when setting an attribute that is a plain old attribute" do
        assert assign_plain_attribute_strict do
          raises_error? RuntimeError
        end
      end
    end

    context "Not strict" do
      example = Settings::Controls::Subject.example

      settable = Settings::Setting::Assignment::Attribute.assure_settable(example, :some_accessor_attribute, strict = false)

      test "Settable when the attribute is a plain old attribute" do
        assert(settable)
      end
    end
  end
end
