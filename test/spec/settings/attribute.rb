module AttributeExample
  class Thing
    extend Settings::Setting::Macro

    setting :some_setting
  end
end

describe "Settings Attribute" do
  specify "Has a getter" do
    thing = AttributeExample::Thing.new
    expect(thing.respond_to? :some_setting).to be
  end

  specify "Has a setter" do
    thing = AttributeExample::Thing.new
    expect(thing.respond_to? :some_setting=).to be
  end
end
