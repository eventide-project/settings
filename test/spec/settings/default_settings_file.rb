describe Settings::File, "default filepath" do
  specify "The default settings file is relative to the settings file directory" do
    current_path = File.dirname(File.expand_path(__FILE__))
    settings_file = File.join(current_path, "settings.json")

    file = Settings::File.new

    file.directory = current_path

    expect(file.pathname == settings_file).to be
  end
end
