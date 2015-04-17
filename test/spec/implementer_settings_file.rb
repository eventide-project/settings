module ImplementerPathname
  def self.settings
    Example.build
  end

  class Example < Settings
    def self.data_source
      ::File.expand_path('../settings.json', __FILE__)
    end
  end
end

describe "Implementer Pathname" do
  specify "A subclass can specify the pathname by implementing a class method named 'pathname'" do
    settings = ImplementerPathname.settings
    pathname = ImplementerPathname::Example.data_source

    assert(settings.pathname == pathname)
  end
end
