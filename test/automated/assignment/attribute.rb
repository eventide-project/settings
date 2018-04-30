require_relative '../automated_init'

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

context "Assignment" do
  context "Attribute" do
    test "Settable when the attribute is a setting" do
      example = AttributeAssignment.example
      assert(AttributeAssignment.assignment.assure_settable(example, :some_setting))
    end

    context "Strict" do
      test "Is an error when setting an attribute that is a plain old attribute" do
        example = AttributeAssignment.example

        assign_plain_attribute_strict = proc do
          AttributeAssignment.assignment.assure_settable(example, :some_attribute, strict = true)
        end

        assert assign_plain_attribute_strict do
          raises_error? RuntimeError
        end
      end
    end

    context "Not strict" do
      test "Settable when the attribute is a plain old attribute" do
        example = AttributeAssignment.example
        assert(AttributeAssignment.assignment.assure_settable(example, :some_attribute, strict = false))
      end
    end
  end
end
