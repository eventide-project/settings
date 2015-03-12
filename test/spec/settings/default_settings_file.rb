describe Settings::File, "default filepath" do
  specify "The default settings filename is used when the path is a directory" do
    current_path = File.dirname(File.expand_path(__FILE__))
    settings_file = File.join(current_path, "settings.json")

    pathname = Settings::File.canonical(current_path)

    expect(pathname == settings_file).to be
  end
end
