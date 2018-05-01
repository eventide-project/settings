require_relative '../automated_init'

context "Data Source" do
  context "Implementer Provides the Data Source" do
    settings = Settings::Controls::DataSource::Implementer.example

    test "A subclass can specify the datasource by implementing a class method named 'datasource'" do
      assert(settings.data == Settings::Controls::DataSource::Hash.data)
    end
  end
end
