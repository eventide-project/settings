require_relative '../automated_init'

module Assignment
  def self.example
    Example.new
  end

  def self.assignment
    Settings::Setting::Assignment
  end

  class Example
    setting :some_setting
    attr_reader :some_attribute
  end
end

context "Assignment" do
  test "Determine whether the attribute is a setting" do
    example = Assignment.example

    assert(Assignment.assignment.setting?(example, :some_setting))
    assert(!Assignment.assignment.setting?(example, :some_attribute))
  end

  test "Determine whether the attribute is assignable" do
    example = Assignment.example

    assert(Assignment.assignment.assignable?(example, :some_setting))
    assert(!Assignment.assignment.assignable?(example, :some_attribute))
  end
end
