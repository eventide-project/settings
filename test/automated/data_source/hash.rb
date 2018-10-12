require_relative '../automated_init'

context "Data Source" do
  context "Hash" do
    hash_source = Controls::DataSource::Hash.example
    data = hash_source.get_data

    test "Converts the data to a Confstruct" do
      assert(data.is_a? Confstruct::Configuration)
    end
  end
end
