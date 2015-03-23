module Override
  def self.data
    {
      "some_setting" => {
        "some_nested_setting" => {
          "another_nested_setting" => "some nested value"
        }
      }
    }
  end

  def self.override_data
    {
      "some_setting" => {
        "some_nested_setting" => {
          "another_nested_setting" => "some other nested value",
          "yet_another_nested_setting" => "yet another nested value"
        }
      }
    }
  end

  def self.override
    s = settings
    s.override(override_data)
    s
  end

  def self.settings
    Settings.build data
  end

  def self.get(*key)
    settings.get key
  end
end

# Namespace, not nested

describe "Override settings" do
  xspecify "An override setting that is in the settings data is replaced by the override data" do
    settings = Override.override

    another_nested_setting = settings.get('some_setting', 'some_nested_setting', 'another_nested_setting')

    assert(another_nested_setting == "some other nested value")
  end

  xspecify "An override setting that is not in the settings data is added to the data" do
    settings = Override.override

    yet_another_nested_setting = settings.get(['some_setting', 'some_nested_setting', 'yet_another_nested_setting'])

    assert(yet_another_nested_setting == "yet another nested value")
  end
end
