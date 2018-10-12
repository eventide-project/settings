require_relative '../automated_init'

context "Data Source" do
  context "Implementer Provides the Data Source" do
    settings = Controls::DataSource::Implementer.example

    test "A subclass can specify the datasource by implementing a class method named 'datasource'" do
      assert(settings.data == Controls::DataSource::Hash.data)
    end
  end
end
