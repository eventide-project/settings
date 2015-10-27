require_relative './spec_init'

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

describe Settings::Setting::Assignment do
  specify "Determine whether the attribute is a setting" do
    example = Assignment.example

    assert(Assignment.assignment.setting?(example, :some_setting))
    refute(Assignment.assignment.setting?(example, :some_attribute))
  end

  specify "Determine whether the attribute is assignable" do
    example = Assignment.example

    assert(Assignment.assignment.assignable?(example, :some_setting))
    refute(Assignment.assignment.assignable?(example, :some_attribute))
  end
end
