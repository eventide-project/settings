require_relative 'automated_init'

context "Key Format" do
  camel_case_data = Controls::Settings::CamelCase.data
  settings = Settings.build(camel_case_data)

  data = settings.data

  test "Underscore cased" do
    assert(data == {
      "some_namespace" => {
        "some_setting" => "some value"
      }
    })
  end
end
