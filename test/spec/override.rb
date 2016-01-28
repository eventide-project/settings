require_relative './spec_init'

module Override
  def self.data
    {
      "some_namespace" => {
        "some_setting" => "some value"
      }
    }
  end

  def self.override_data
    {
      "some_namespace" => {
        "some_setting" => "some overridden value",
        "some_other_setting" => "some other value"
      }
    }
  end

  def self.override
    s = settings
    s.override(override_data)
    s
  end

  def self.settings
    Settings.build data
  end

  def self.get(*key)
    settings.get key
  end
end

context "Override settings" do
  test "An override setting that is in the settings data is replaced by the override data" do
    settings = Override.override
    overridden_setting = settings.get(:some_namespace, :some_setting)

    assert(overridden_setting == "some overridden value")
  end

  test "An override setting that is not in the settings data is added to the data" do
    settings = Override.override
    some_other_setting = settings.get(:some_namespace, :some_other_setting)

    assert(some_other_setting == "some other value")
  end
end
