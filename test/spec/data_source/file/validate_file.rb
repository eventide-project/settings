describe Settings::File, "validation" do
  specify "A file that doesn't exist is invalid" do
    file_that_doesnt_exist = "file-that-does-not-exist.json"

    assert_raises RuntimeError do
      Settings::File.validate(file_that_doesnt_exist)
    end
  end
end
