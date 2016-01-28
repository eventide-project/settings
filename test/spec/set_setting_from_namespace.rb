require_relative './spec_init'

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

context "Set a setting attribute from a namespace" do
  test "Assigns data from within that namespace to the corresponding attribute" do
    example = SetSettingFromNamespace.example
    SetSettingFromNamespace.settings.set example, "some_namespace"

    assert(example.some_setting == "some value")
  end
end
