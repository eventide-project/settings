require 'json'

data = JSON.load <<JSON
  {
    "some_setting": "some value"
  }
JSON

describe Settings do
  subject(:settings) { Settings.new data }
  let(:setting) { settings.get key }

  describe "Getting" do
    describe "A setting" do
      let(:key) { 'some_setting' }
      specify "Gets the value" do
        expect(setting).to eq 'some value'
      end
    end

    describe "A setting that isn't in the data" do
      let(:key) { 'a_setting_that_isnt_in_the_data' }
      specify "Gets nil" do
        expect(setting).to be_nil
      end
    end
  end
end
