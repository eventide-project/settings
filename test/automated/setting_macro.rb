require_relative './automated_init'

module SettingMacro
  class Example
    setting :some_setting
  end
end

context "Setting Macro" do
  context "Generated Attribute" do
    example = SettingMacro::Example.new

    test "Has a getter" do
      assert(example.respond_to?(:some_setting))
    end

    test "Has a setter" do
      assert(example.respond_to?(:some_setting=))
    end
  end
end
