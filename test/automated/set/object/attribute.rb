require_relative '../../automated_init'

context "Set" do
  context "Object Attribute" do
    context "Strict" do
      settings = Controls::Settings::AccessorAttribute.example

      example = Controls::Subject.example

      settings.set(example)

      test "Attributes are not set" do
        assert(example.some_accessor_attribute.nil?)
      end
    end

    context "Not Strict" do
      settings = Controls::Settings::AccessorAttribute.example

      example = Controls::Subject.example

      settings.set(example, strict: false)

      test "Attributes are set" do
        assert(example.some_accessor_attribute == 'some accessor value')
      end
    end
  end
end
