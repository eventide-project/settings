module GetSettingFromNamespace
  def self.data
    {
      "some_namespace" => {
        "some_setting" => "some value"
      }
    }
  end

  def self.settings
    Settings.new data
  end

  def self.get(*key)
    settings.get *key
  end
end

describe "Get a setting from a namespace" do
  specify "Gets the setting's value" do
    value = GetSettingFromNamespace.get :some_namespace, :some_setting
    assert(value == "some value")
  end
end
