describe Settings::File, "default filename" do
  specify "The default settings filename is used when the path is a directory" do
    current_path = File.dirname(File.expand_path(__FILE__))
    settings_file = File.join(current_path, "settings.json")

    pathname = Settings::File.canonical(current_path)

    expect(pathname == settings_file).to be
  end
end

describe Settings, "default pathname" do
  specify "The current working directory and the default filename are used when the path is not specified" do
    current_path = File.dirname(File.expand_path(__FILE__))

    settings = nil
    Dir.chdir(current_path) do
      settings = Settings.build
    end

    expect(settings.pathname == "settings.json").to be
  end
end
