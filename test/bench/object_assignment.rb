require_relative './bench_init'

module ObjectAssignment
  def self.example
    Example.new
  end

  def self.assignment
    Settings::Setting::Assignment::Object
  end

  class Example
    setting :some_setting
    attr_accessor :some_attribute
  end
end

context "Object Assignment" do
  test "Settable when the attribute is a setting" do
    example = ObjectAssignment.example
    assert(ObjectAssignment.assignment.assure_settable(example, :some_setting))
  end

  context "Strict" do
    test "Attribute is not settable when it's a plain old attribute" do
      example = ObjectAssignment.example
      assert(!ObjectAssignment.assignment.assure_settable(example, :some_attribute, strict = true))
    end
  end

  context "Not strict" do
    test "Settable when the attribute is a plain old attribute" do
      example = ObjectAssignment.example
      assert(ObjectAssignment.assignment.assure_settable(example, :some_attribute, strict = false))
    end
  end
end
