require_relative './automated_init'

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

context "Override" do
  context "Setting That Is in the Data" do
    settings = Override.override

    overridden_setting = settings.get(:some_namespace, :some_setting)

    test "Is replaced by the override data" do
      assert(overridden_setting == "some overridden value")
    end
  end

  context "Setting That Is Not in the Data" do
    settings = Override.override

    some_other_setting = settings.get(:some_namespace, :some_other_setting)

    test "Is added to the data" do
      assert(some_other_setting == "some other value")
    end
  end
end
