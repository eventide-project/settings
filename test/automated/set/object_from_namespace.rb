require_relative '../automated_init'

module SetObjectFromNamespace
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
  context "Set an Object from a Namespace" do
    context "Corresponding Attributes" do
      example = SetObjectFromNamespace.example

      SetObjectFromNamespace.settings.set(example, "some_namespace")

      test "Assigns data to the attributes" do
        assert(example.some_setting == "some value")
      end
    end

    context "Namespace isn't found in data" do
      example = SetObjectFromNamespace.example

      test "Is an error" do
        assert proc { SetObjectFromNamespace.settings.set example, "other_namespace" } do
          raises_error? Settings::Error
        end
      end
    end
  end
end
