module AttributeExample
  class Thing
    extend Settings::Setting::Macro

    setting :some_setting
  end
end

describe "Settings attribute", :* do
  specify "Has a getter" do
    thing = AttributeExample::Thing.new
    expect(thing.respond_to? :some_setting).to be
  end

  specify "Has a setter" do
    thing = AttributeExample::Thing.new
    expect(thing.respond_to? :some_setting=).to be
  end

  specify "Is not registered" do
    registry = Settings::Registry.instance

    expect(registry.setting? AttributeExample::Thing, :some_setting).to be
  end
end
