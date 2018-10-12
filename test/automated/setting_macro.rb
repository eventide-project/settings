require_relative './automated_init'

context "Setting Macro" do
  context "Generated Attribute" do
    example = Controls::Subject.example

    test "Has a getter" do
      assert(example.respond_to?(:some_setting))
    end

    test "Has a setter" do
      assert(example.respond_to?(:some_setting=))
    end
  end
end
