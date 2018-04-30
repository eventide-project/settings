require_relative '../../automated_init'

module Canonical
  def self.canonical(path)
    Settings::DataSource::File.canonical(path)
  end

  def self.current_dir
    File.dirname(File.expand_path(__FILE__))
  end

  def self.default_filename
    'settings.json'
  end

  def self.current_dir_filepath
    File.join(current_dir, "settings.json")
  end

  def self.working_dir_filepath(filepath=nil)
    filepath ||= default_filename
    File.join(Dir.pwd, filepath)
  end
end

context "Data Source" do
  context "File" do
    context "Canonical Filepath" do
      test "The default settings filename (settings.json) is used when the source is a directory" do
        pathname = Canonical.canonical(Canonical.current_dir)

        assert(pathname == Canonical.current_dir_filepath)
      end

      test "The default directory (current working directory) is used when the source is a filename" do
        pathname = Canonical.canonical('some_file.json')

        assert(pathname == Canonical.working_dir_filepath('some_file.json'))
      end

      test "The default directory and the default filename are used when the path is not specified" do
        pathname = Canonical.canonical(nil)

        assert(pathname == Canonical.working_dir_filepath)
      end

      test "The specified pathname is used when it includes both the directory and the filename" do
        pathname = Canonical.canonical('some_dir/some_file.json')

        assert(pathname == 'some_dir/some_file.json')
      end
    end
  end
end
