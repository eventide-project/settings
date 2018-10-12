require_relative '../automated_init'

context "Assignment" do
  test "Determine whether the attribute is a setting" do
    example = Controls::Subject.example

    assert(Settings::Setting::Assignment.setting?(example, :some_setting))
    refute(Settings::Setting::Assignment.setting?(example, :some_reader_attribute))
  end

  test "Determine whether the attribute is assignable" do
    example = Controls::Subject.example

    assert(Settings::Setting::Assignment.assignable?(example, :some_setting))
    refute(Settings::Setting::Assignment.assignable?(example, :some_reader_attribute))
  end
end
