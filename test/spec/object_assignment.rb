require_relative './spec_init'

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

describe "Object Assignment" do
  describe Settings::Setting::Assignment::Object do
    specify "Settable when the attribute is a setting" do
      example = ObjectAssignment.example
      assert(ObjectAssignment.assignment.assure_settable(example, :some_setting))
    end
  end

  describe Settings::Setting::Assignment::Object, "Strict" do
    specify "Is not settable when the attribute is a plain old attribute" do
      example = ObjectAssignment.example
      refute(ObjectAssignment.assignment.assure_settable(example, :some_attribute, strict = true))
    end
  end

  describe Settings::Setting::Assignment::Object, "Not strict" do
    specify "Settable when the attribute is a plain old attribute" do
      example = ObjectAssignment.example
      assert(ObjectAssignment.assignment.assure_settable(example, :some_attribute, strict = false))
    end
  end
end
