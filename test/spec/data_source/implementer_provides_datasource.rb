module ImplementerProvidesDataSource
  def self.settings
    Example.build
  end

  class Example < Settings
    def self.data_source
      ::File.expand_path('../../settings.json', __FILE__)
    end
  end
end

describe "Implementer Provides the Data Source" do
  specify "A subclass can specify the datasource by implementing a class method named 'datasource'" do
    settings = ImplementerProvidesDataSource.settings
    pathname = ImplementerProvidesDataSource::Example.data_source

    assert(settings.pathname == pathname)
  end
end
