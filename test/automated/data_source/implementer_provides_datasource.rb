require_relative '../automated_init'

module ImplementerProvidesDataSource
  def self.settings
    Example.build
  end

  def self.data
    {
      some_other_setting: "some other value"
    }
  end

  class Example < Settings
    def self.data_source
      ImplementerProvidesDataSource.data
    end
  end
end

context "Data Source" do
  context "Implementer Provides the Data Source" do
    settings = ImplementerProvidesDataSource.settings

    test "A subclass can specify the datasource by implementing a class method named 'datasource'" do
      assert(settings.data == ImplementerProvidesDataSource.data)
    end
  end
end
