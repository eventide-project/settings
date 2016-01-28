require_relative './spec_init'

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

context "Attribute Assignment" do
  context Settings::Setting::Assignment::Attribute do
    test "Settable when the attribute is a setting" do
      example = AttributeAssignment.example
      assert(AttributeAssignment.assignment.assure_settable(example, :some_setting))
    end

    context "Strict" do
      test "Is an error when the attribute is a plain old attribute" do
        example = AttributeAssignment.example

        begin
          AttributeAssignment.assignment.assure_settable(example, :some_attribute, strict = true)
        rescue RuntimeError => error
        end

        assert error
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
