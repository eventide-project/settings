describe Settings::File do
  subject(:file) { Settings::File.instance }
  let(:settings_file) { File.join(current_path, "settings.json") }
  let(:current_path) { File.dirname(File.expand_path(__FILE__)) }

  describe "Filename" do
    before do
      Settings::File.instance.directory = current_path
    end

    specify "Is relative to the settings file path" do
      expect(file.pathname).to eq settings_file
    end
  end
end
