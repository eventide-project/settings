require_relative '../automated_init'

context "Data Source" do
  context "Type" do
    context "Hash is the source" do
      data_source_type = Settings::DataSource::Build.type({})

      test "DataSource::Hash" do
        assert(data_source_type == Settings::DataSource::Hash)
      end
    end

    context "Filepath is the source" do
      data_source_type = Settings::DataSource::Build.type('some_filepath')

      test "DataSource::File" do
        assert(data_source_type == Settings::DataSource::File)
      end
    end

    context "Source is nil" do
      data_source_type = Settings::DataSource::Build.type

      test "DataSource::File" do
        assert(data_source_type == Settings::DataSource::File)
      end
    end
  end
end
