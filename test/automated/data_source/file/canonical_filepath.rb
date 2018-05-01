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
      context "Source is a Directory" do
        pathname = Canonical.canonical(Canonical.current_dir)

        test "The default settings filename (settings.json) is used" do
          assert(pathname == Canonical.current_dir_filepath)
        end
      end

      context "Source is a Filename" do
        pathname = Canonical.canonical('some_file.json')

        test "The current working directory is used" do
          assert(pathname == Canonical.working_dir_filepath('some_file.json'))
        end
      end

      context "Source Is Not Specified" do
        pathname = Canonical.canonical(nil)

        test "The default directory and the default filename are used" do
          assert(pathname == Canonical.working_dir_filepath)
        end
      end

      context "Source includes both a directory and filename" do
        pathname = Canonical.canonical('some_dir/some_file.json')

        test "The source is used" do
          assert(pathname == 'some_dir/some_file.json')
        end
      end
    end
  end
end
