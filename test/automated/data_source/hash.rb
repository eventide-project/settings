require_relative '../automated_init'

context "Data Source" do
  context "Hash" do
    hash_source = Controls::DataSource::Hash.example
    data = hash_source.get_data

    test "Converts the data to a Hash" do
      assert(data.is_a? Hash)
    end
  end
end
