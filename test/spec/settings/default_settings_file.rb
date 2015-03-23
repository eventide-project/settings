describe Settings::File, "default filename" do
  specify "The default settings filename is used when the path is a directory" do
    current_path = File.dirname(File.expand_path(__FILE__))
    settings_file = File.join(current_path, "settings.json")

    pathname = Settings::File.canonical(current_path)

    assert(pathname == settings_file)
  end

  specify "The current working directory is used when the path is a filename" do
    current_path = Dir.pwd
    settings_file = File.join(current_path, "settings.json")

    pathname = nil
    Dir.chdir(current_path) do
      pathname = Settings::File.canonical("settings.json")
    end

    expect(pathname == settings_file).to be
  end
end

describe Settings, "default pathname" do
  specify "The current working directory and the default filename are used when the path is not specified" do
    current_path = File.dirname(File.expand_path(__FILE__))
    settings_file = File.join(current_path, "settings.json")

    settings = nil
    Dir.chdir(current_path) do
      settings = Settings.build
    end

    expect(settings.pathname == settings_file).to be
  end
end
