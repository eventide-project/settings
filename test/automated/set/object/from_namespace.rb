require_relative '../../automated_init'

context "Set" do
  context "From a Namespace" do
    context "Corresponding Attributes" do
      example = Controls::Subject.example

      settings = Controls::Settings::Namespace.example

      settings.set(example, 'some_namespace')

      test "Assigns data to the attributes" do
        assert(example.some_setting == 'some value')
      end
    end

    context "Namespace isn't found in data" do
      example = Controls::Subject.example

      settings = Controls::Settings::Namespace.example

      random_namespace = SecureRandom.hex

      test "Is an error" do
        assert proc { settings.set(example, random_namespace) } do
          raises_error? Settings::Error
        end
      end
    end
  end
end
