module AttributeExample
  class Thing
    extend Settings::Setting::Macro

    setting :some_setting
    attr_accessor :some_attribute
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

  specify "Is in the Settings registry" do
    registry = Settings::Registry.instance

    expect(registry.setting? AttributeExample::Thing, :some_setting).to be
  end
end

describe "Attribute Accessor" do
  specify "Is not in the Settings registry" do
    registry = Settings::Registry.instance

    expect(registry.setting? AttributeExample::Thing, :some_attribute).to_not be
  end
end
