require_relative '../automated_init'

module SetSettingFromNamespace
  def self.data
    {
      "some_namespace" => {
        "some_setting" => "some value"
      }
    }
  end

  def self.settings
    Settings.build(data)
  end

  def self.example
    Example.new
  end

  class Example
    setting :some_setting
  end
end

context "Set" do
  context "Setting from Namespace" do
    example = SetSettingFromNamespace.example

    SetSettingFromNamespace.settings.set(example, "some_namespace")

    test "Assigns data from within the namespace to the corresponding attribute" do
      assert(example.some_setting == "some value")
    end
  end
end
