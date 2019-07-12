require_relative '../automated_init'

context "Data Keys" do
  context "Symbols" do
    symbol_key_data = Controls::Data::SymbolKeys.example
    settings = Settings.build(symbol_key_data)

    data = settings.data

    test "Converted to strings" do
      assert(data == {
        'some_namespace' => {
          'some_setting' => 'some value'
        }
      })
    end
  end
end
