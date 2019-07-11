require_relative '../automated_init'

context "Data Source" do
  context "Implementer Provides the Data Source" do
    settings = Controls::DataSource::Implementer.example

    test "A subclass can specify the data_source by implementing a class method named 'data_source'" do
      assert(settings.data == Controls::DataSource::Hash.data)
    end
  end
end
