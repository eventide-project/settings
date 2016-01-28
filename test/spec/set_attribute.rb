require_relative './spec_init'

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

context "Set a plain old attribute" do
  test "When setting strictly, it's an error" do
    example = SetPlainOldAttribute.example

    begin
      SetPlainOldAttribute.settings.set example, attribute: :some_attr
    rescue RuntimeError => error
    end

    assert error
  end

  test "When not setting strictly, sets the attribute" do
    example = SetPlainOldAttribute.example
    SetPlainOldAttribute.settings.set example, attribute: :some_attr, strict: false

    assert(example.some_attr == "some attr value")
  end
end
