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

describe "Implementer Provides the Data Source" do
  specify "A subclass can specify the datasource by implementing a class method named 'datasource'" do
    settings = ImplementerProvidesDataSource.settings

    assert(settings.data == ImplementerProvidesDataSource.data)
  end
end
