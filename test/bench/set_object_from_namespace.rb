require_relative './bench_init'

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

context "Set an object from a namespace" do
  test "Assigns data from within that namespace to corresponding setting attributes" do
    example = SetObjectFromNamespace.example
    SetObjectFromNamespace.settings.set example, "some_namespace"

    assert(example.some_setting == "some value")
  end

  test "When namespace isn't found in data, it's an error" do
    example = SetObjectFromNamespace.example

    assert proc { SetObjectFromNamespace.settings.set example, "other_namespace" } do
      raises_error? Settings::Error
    end
  end
end
