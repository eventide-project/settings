require_relative '../../spec_init'

describe "File Data Source Validation" do
  specify "A file that doesn't exist is invalid" do
    file_that_doesnt_exist = "file-that-does-not-exist.json"

    assert_raises RuntimeError do
      Settings::DataSource::File.validate(file_that_doesnt_exist)
    end
  end

  specify "A file that does exist is valid" do
    settings_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    settings_file = File.join(settings_dir, 'settings.json')

    Settings::DataSource::File.validate(settings_file)
  end
end
