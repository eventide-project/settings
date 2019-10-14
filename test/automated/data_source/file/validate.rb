require_relative '../../automated_init'

context "Data Source" do
  context "File" do
    context "Validate" do
      context "File Doesn't Exist" do
        random_filename = SecureRandom.hex
        file_that_doesnt_exist = "#{random_filename}.json"

        test "Is invalid" do
          assert_raises Settings::Error do
            Settings::DataSource::File.validate(file_that_doesnt_exist)
          end
        end
      end

      context "File Does Exist" do
        settings_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
        settings_file = File.join(settings_dir, 'settings.json')

        test "Is valid" do
          refute_raises Settings::Error do
            Settings::DataSource::File.validate(settings_file)
          end
        end
      end
    end
  end
end
