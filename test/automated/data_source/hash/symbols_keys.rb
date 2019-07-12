require_relative '../../automated_init'

context "Data Source" do
  context "Hash" do
    context "Symbol Keys" do
      hash_source = Controls::DataSource::Hash::SymbolKeys.example
      data = hash_source.get_data

      test "Converted to strings" do
        assert(data == {
          'some_namespace' => {
            'some_setting' => 'some value'
          }
        })
      end
    end
  end
end
