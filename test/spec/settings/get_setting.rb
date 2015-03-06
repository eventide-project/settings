require 'json'

data = JSON.load <<JSON
  {
    "some_setting": "some value"
  }
JSON

class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def get(key)
    data[key]
  end
end

describe "Settings" do
  let(:settings) { Settings.new data }
  let(:setting) { settings.get 'some_setting' }
  specify "Get a setting" do
    expect(setting).to eq 'some value'
  end

  describe "A setting that isn't in the data" do
    let(:setting) { settings.get 'a_setting_that_doesnt_exist'}
    specify "Is nil" do
      expect(setting).to be_nil
    end
  end
end
