data = {
  "some_setting" => {
    "some_nested_setting" => {
    	"another_nested_setting" => "some nested value"
    }
  }
}

describe Settings do
  specify "Getting a nested setting from the setting data gets the setting's value and descendant values" do
    settings = Settings.new data
    key = ['some_setting', 'some_nested_setting']
    setting = settings.get key

    expect(setting == Hash[ "another_nested_setting" => "some nested value" ]).to be
  end
end
