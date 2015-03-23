module SetObject
  def self.data
    {
      "some_setting" => "some value",
      "some_other_setting" => "some other value",
      "some_attr" => "some attr value",
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

describe "Set an object" do
  specify "Assigns data to corresponding setting attributes" do
    example = SetObject.example
    SetObject.settings.set example

    assert(example.some_setting == "some value")
    assert(example.some_other_setting == "some other value")
  end

  specify "A setting that does not have corresponding data is not set" do
    example = SetObject.example
    SetObject.settings.set example

    assert(example.not_in_the_data.nil?)
  end
end
