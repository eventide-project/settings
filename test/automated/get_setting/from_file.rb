require_relative '../automated_init'

context "Get Setting" do
  context "From a file" do
    settings_file = File.join(File.dirname(File.expand_path(__FILE__)), '../settings.json')

    settings = Settings.build(settings_file)

    setting = settings.get('some_setting')

    test "Retrieves the data from the file" do
      assert(setting == 'some value')
    end
  end
end
