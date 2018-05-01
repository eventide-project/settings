require_relative '../automated_init'

module GetSetting
  def self.data
    {
      "some_setting" => "some value"
    }
  end

  def self.settings
    Settings.new data
  end

  def self.get(key)
    settings.get key
  end
end

context "Get Setting" do
  context "Setting is in the data" do
    setting = GetSetting.get 'some_setting'

    test "Gets the setting's value" do
      assert(setting == 'some value')
    end
  end

  context "Setting isn't in the data" do
    setting = GetSetting.get 'setting_that_isnt_in_the_data'

    test "Gets nil" do
      assert(setting == nil)
    end
  end
end
