require_relative '../automated_init'

context "Data Keys" do
  context "Type" do
    string_key_data = Controls::Data::StringKeys.example
    settings = Settings.build(string_key_data)

    data = settings.data
pp data
    test "Symbol" do
      assert(data == {
        :some_namespace => {
          :some_setting => "some value"
        }
      })
    end
  end
end
