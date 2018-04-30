require_relative '../automated_init'

context "Data Source" do
  context "Type" do
    test "DataSource::Hash when the input is a hash" do
      data_source_type = Settings::DataSource::Build.type({})
      assert(data_source_type == Settings::DataSource::Hash)
    end

    test "DataSource::File when the data source is a filepath string" do
      data_source_type = Settings::DataSource::Build.type('some_filepath')
      assert(data_source_type == Settings::DataSource::File)
    end

    test "DataSource::File when the data source is nil" do
      data_source_type = Settings::DataSource::Build.type
      assert(data_source_type == Settings::DataSource::File)
    end
  end
end
