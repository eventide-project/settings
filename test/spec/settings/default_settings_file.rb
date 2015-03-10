describe Settings::File, "default filepath" do
  specify "The default settings file is relative to the configured settings file directory" do
    current_path = File.dirname(File.expand_path(__FILE__))
    settings_file = File.join(current_path, "settings.json")

    file = Settings::File.instance

    file.directory = current_path

    expect(file.pathname == settings_file).to be
  end

  # specify "The default settings file is relative to the configured settings file directory" do
  #   current_path = File.dirname(File.expand_path(__FILE__))
  #   settings_file = File.join(current_path, "settings.json")

  #   file = Settings::File.instance

  #   expect(file.pathname == settings_file).to be
  # end
end
