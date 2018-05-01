require_relative '../automated_init'

module SetObjectPlainOldAttribute
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

context "Set" do
  context "Object Attribute" do
    context "Strict" do
      example = SetObjectPlainOldAttribute.example

      SetObjectPlainOldAttribute.settings.set(example)

      test "Attributes are not set" do
        assert(example.some_attr.nil?)
      end
    end

    context "Not strict" do
      example = SetObjectPlainOldAttribute.example

      SetObjectPlainOldAttribute.settings.set(example, strict: false)

      test "When not setting strictly, sets the attribute" do
        assert(example.some_attr == "some attr value")
      end
    end
  end
end
