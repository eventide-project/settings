require_relative '../../automated_init'

context "Data Source" do
  context "File" do
    context "Validate" do
      context "File Doesn't Exist" do
        file_that_doesnt_exist = 'file-that-does-not-exist.json'

        validate_file_that_doesnt_exist = proc do
          Settings::DataSource::File.validate(file_that_doesnt_exist)
        end

        test "Is invalid" do
          assert validate_file_that_doesnt_exist do
            raises_error? Settings::Error
          end
        end
      end

      context "File Does Exist" do
        settings_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
        settings_file = File.join(settings_dir, 'settings.json')

        test "Is valid" do
          Settings::DataSource::File.validate(settings_file)
        end
      end
    end
  end
end
