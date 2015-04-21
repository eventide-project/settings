describe "Data Source Type", :* do
  specify "DataSource::Hash when the input is a hash" do
    data_source = Settings::DataSource.build({})
    assert(data_source.is_a?(Settings::DataSource::Hash))
  end

  specify "DataSource::File when the data source is a filepath string"
end
