require_relative '../../bench_init'

context "File Data Source Validation" do
  test "A file that doesn't exist is invalid" do
    file_that_doesnt_exist = "file-that-does-not-exist.json"

    assert Settings::DataSource::File do
      error? RuntimeError do
        Settings::DataSource::File.validate(file_that_doesnt_exist)
      end
    end
  end

  test "A file that does exist is valid" do
    settings_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    settings_file = File.join(settings_dir, 'settings.json')

    Settings::DataSource::File.validate(settings_file)
  end
end
