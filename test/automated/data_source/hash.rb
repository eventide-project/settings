require_relative '../automated_init'

module HashDataSource
  def self.build
    Settings::DataSource::Hash.build(data)
  end

  def self.data
    {
      some_setting: 'some value'
    }
  end
end

context "Data Source" do
  context "Hash" do
    hash_source = HashDataSource.build
    data = hash_source.get_data

    test "Converts the data to a Confstruct" do
      assert(data.is_a? Confstruct::Configuration)
    end
  end
end
