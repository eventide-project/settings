require_relative '../../automated_init'

context "Set" do
  context "Object" do
    context "Corresponding Setting Attributes" do
      example = Controls::Subject.example
      settings = Controls::Settings::SettingAttributes::Partial.example

      settings.set(example)

      test "Assigns data to the attributes" do
        assert(example.some_setting == 'some value')
        assert(example.some_other_setting == 'some other value')
      end
    end
  end

  context "Attributes that Don't Correspond" do
    example = Controls::Subject.example
    settings = Controls::Settings::SettingAttributes::Partial.example

    settings.set(example)

    test "Data is not set" do
      assert(example.yet_another_setting.nil?)
    end
  end
end
