require_relative '../automated_init'

context "Assignment" do
  context "Object" do
    context "Attribute Is a Setting" do
      example = Settings::Controls::Subject.example

      settable = Settings::Setting::Assignment::Object.assure_settable(example, :some_setting)

      test "Settable when the attribute is a setting" do
        assert(settable)
      end
    end

    context "Plain Attribute" do
      context "Strict" do
        example = Settings::Controls::Subject.example

        settable = Settings::Setting::Assignment::Object.assure_settable(example, :some_attribute, strict = true)

        test "Not settable" do
          refute(settable)
        end
      end

      context "Not strict" do
        example = Settings::Controls::Subject.example

        settable = Settings::Setting::Assignment::Object.assure_settable(example, :some_accessor_attribute, strict = false)

        test "Settable" do
          assert(settable)
        end
      end
    end
  end
end
