describe "Data Source Type" do
  specify "DataSource::Hash when the input is a hash" do
    data_source_type = Settings::DataSource.type({})
    assert(data_source_type == Settings::DataSource::Hash)
  end

  specify "DataSource::File when the data source is a filepath string" do
    data_source_type = Settings::DataSource.type('some_filepath')
    assert(data_source_type == Settings::DataSource::File)
  end
end
