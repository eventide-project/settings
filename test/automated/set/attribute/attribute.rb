require_relative '../../automated_init'

context "Set" do
  context "Attribute" do
    settings = Controls::Settings::AccessorAttribute.example

    context "Strict" do
      example = Controls::Subject.example

      set_attribute = proc do
        settings.set(example, attribute: :some_accessor_attribute)
      end

      test "Is an error" do
        assert set_attribute do
          raises_error? RuntimeError
        end
      end
    end

    context "Not Strict" do
      example = Controls::Subject.example

      settings.set(example, attribute: :some_accessor_attribute, strict: false)

      test "Sets the attribute" do
        assert(example.some_accessor_attribute == 'some accessor value')
      end
    end
  end
end
