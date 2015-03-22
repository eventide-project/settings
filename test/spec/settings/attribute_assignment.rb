module AttributeAssignment
  def self.example
    Example.new
  end

  def self.assignment
    Settings::Setting::Assignment::Attribute
  end

  class Example
    setting :some_setting
    attr_accessor :some_attribute
  end
end

describe Settings::Setting::Assignment::Attribute do
  specify "Settable when the attribute is a setting" do
    example = AttributeAssignment.example
    assert(AttributeAssignment.assignment.assure_settable(example, :some_setting))
  end
end

describe Settings::Setting::Assignment::Attribute, "Strict" do
  specify "Is an error when the attribute is a plain old attribute" do
    example = AttributeAssignment.example

    assert_raises RuntimeError do
      AttributeAssignment.assignment.assure_settable(example, :some_attribute, strict = true)
    end
  end
end

describe Settings::Setting::Assignment::Attribute, "Not strict" do
  specify "Settable when the attribute is a plain old attribute" do
    example = AttributeAssignment.example
    assert(AttributeAssignment.assignment.assure_settable(example, :some_attribute, strict = false))
  end
end
