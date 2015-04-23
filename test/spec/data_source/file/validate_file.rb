# describe Settings::File, "validation" do
#   specify "A file that doesn't exist is invalid" do
#     file_that_doesnt_exist = "file-that-does-not-exist.json"
#     data_source = Settings::DataSource::File.build(file_that_doesnt_exist)

#     assert_raises RuntimeError do
#       data_source.validate
#     end
#   end
# end
