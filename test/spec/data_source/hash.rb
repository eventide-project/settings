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

describe "Hash Data Source" do
  specify "Converts the data to a Confstruct" do
    hash_source = HashDataSource.build
    data = hash_source.get
    assert(data.is_a? Confstruct::Configuration)
  end
end
