require_relative '../../automated_init'

context "Data Source" do
  context "File" do
    context "Camel Case Formatted" do
      settings_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
      settings_file = File.join(settings_dir, 'settings_camel_case.json')

      settings = Settings::DataSource::File.build(settings_file)
      data = settings.get_data

      test "Reads the file" do
        assert(data.to_h == { some_setting: 'some value' })
      end
    end
  end
end
