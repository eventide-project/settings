require_relative '../automated_init'

context "Get Setting" do
  context "From a namespace" do
    settings = Settings::Controls::Settings::Namespace.example
    value = settings.get(:some_namespace, :some_setting)

    test "Gets the setting's value" do
      assert(value == 'some value')
    end
  end
end
