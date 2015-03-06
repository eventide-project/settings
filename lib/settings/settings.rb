class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def get(key)
    data[key]
  end
end
