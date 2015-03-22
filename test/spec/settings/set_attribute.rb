module SetPlainOldAttribute
  def self.data
    {
      "some_attr" => "some attr value"
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

describe "Set a plain old attribute", :* do
  specify "When setting strictly, it's an error" do
    example = SetPlainOldAttribute.example

    assert_raises RuntimeError do
      SetPlainOldAttribute.settings.set example, attribute: :some_attr
    end
  end

  specify "When not setting strictly, sets the attribute" do
    example = SetPlainOldAttribute.example
    SetPlainOldAttribute.settings.set example, attribute: :some_attr, strict: false

    assert(example.some_attr == "some attr value")
  end
end
