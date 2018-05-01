require_relative '../automated_init'

module SetObject
  def self.data
    {
      "some_setting" => "some value",
      "some_other_setting" => "some other value",
      "some_attr" => "some attr value"
    }
  end

  def self.settings
    Settings.build(data)
  end

  def self.example
    Example.new
  end

  class Example
    setting :some_setting
    setting :some_other_setting
    setting :not_in_the_data
  end
end

context "Set an object" do
  context "Corresponding Setting Attributes" do
    example = SetObject.example
    SetObject.settings.set example

    test "Assigns data to the attributes" do
      assert(example.some_setting == "some value")
      assert(example.some_other_setting == "some other value")
    end
  end

  context "Attributes that Don't Correspond" do
    example = SetObject.example
    SetObject.settings.set example

    test "Data is not set" do
      assert(example.not_in_the_data.nil?)
    end
  end
end
