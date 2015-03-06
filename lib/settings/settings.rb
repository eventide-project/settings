class Settings
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def get(*key)
  	key.flatten! if key.is_a? Array
  	key.inject(data) {|memo, k| memo[k] }
  end
end
