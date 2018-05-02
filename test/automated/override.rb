require_relative './automated_init'

context "Override" do
  context "Setting That Is in the Data" do
    settings = Settings::Controls::Settings::Namespace::Override.example

    overridden_setting = settings.get(:some_namespace, :some_setting)

    test "Is replaced by the override data" do
      assert(overridden_setting == 'some overridden value')
    end
  end

  context "Setting That Is Not in the Data" do
    settings = Settings::Controls::Settings::Namespace::Override.example

    some_other_setting = settings.get(:some_namespace, :some_other_setting)

    test "Is added to the data" do
      assert(some_other_setting == 'some other value')
    end
  end
end
