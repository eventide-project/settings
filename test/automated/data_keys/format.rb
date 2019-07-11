require_relative '../automated_init'

context "Data Keys" do
  context "Format" do
    camel_case_key_data = Controls::Data::CamelCaseKeys.example
    settings = Settings.build(camel_case_key_data)

    data = settings.data

    test "Underscore cased" do
      assert(data == {
        "some_namespace" => {
          "some_setting" => "some value"
        }
      })
    end
  end
end
