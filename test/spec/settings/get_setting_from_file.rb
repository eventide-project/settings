describe Settings do
  subject(:settings) { Settings.build(settings_file) }
  let(:settings_file) { File.join(File.dirname(File.expand_path(__FILE__)), "single_setting.json") }
  let(:setting) { subject.get key }

  describe "Get a setting" do
    let(:key) { 'some_setting' }
    specify "Gets the value" do
      expect(setting).to eq 'some value'
    end
  end
end
