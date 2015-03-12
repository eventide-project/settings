describe Settings::File do
  specify "A file that doesn't exist is invalid" do
    file_that_doesnt_exist = File.join(File.dirname(File.expand_path(__FILE__)), "file-that-does-not-exist.json")

    expect{Settings::File.validate(file_that_doesnt_exist)}.to raise_error(Errno::ENOENT)
  end
end
