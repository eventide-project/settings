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

context "Hash Data Source" do
  test "Converts the data to a Confstruct" do
    hash_source = HashDataSource.build
    data = hash_source.get_data
    assert(data.is_a? Confstruct::Configuration)
  end
end
