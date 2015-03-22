module SetObjectPlainOldAttribute
  def self.data
    {
      "some_attr" => "some attr value",
    }
  end

  def self.settings
    Settings.build(data)
  end

  def self.example
    Example.new
  end

  class Example
    attr_accessor :some_attr
  end
end

describe "Set an object" do
  specify "When setting strictly, plain old attributes are not set" do
    example = SetObjectPlainOldAttribute.example
    SetObjectPlainOldAttribute.settings.set example

    assert(example.some_attr.nil?)
  end

  specify "When not setting strictly, sets the attribute" do
    example = SetObjectPlainOldAttribute.example
    SetObjectPlainOldAttribute.settings.set example, strict: false

    assert(example.some_attr == "some attr value")
  end
end
