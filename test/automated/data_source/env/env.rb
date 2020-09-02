require_relative '../../automated_init'

context "Data Source" do
  context "Env" do
    value = SecureRandom.hex
    env_var_name = "VAR_#{value.upcase}"
    setting_name = env_var_name.downcase

    ENV[env_var_name] = value

    env_source = Settings::DataSource::Env.build(ENV)

    data = env_source.get_data

    test "Data is converted to hash" do
      assert(data.is_a?(Hash))
    end

    context "Source Value" do
      source_value = data[setting_name]

      test "Key converted to lower case" do
        assert(source_value == value)
      end
    end

    ENV.delete(env_var_name)
    assert(ENV[env_var_name].nil?)
  end
end
