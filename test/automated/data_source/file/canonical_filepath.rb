require_relative '../../automated_init'

context "Data Source" do
  fixture = Module.new do
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
      File.join(current_dir, default_filename)
    end

    def self.working_dir_filepath(filepath=nil)
      filepath ||= default_filename
      File.join(Dir.pwd, filepath)
    end
  end

  context "File" do
    context "Canonical Filepath" do
      context "Source is a Directory" do
        pathname = fixture.canonical(fixture.current_dir)

        test "The default settings filename (settings.json) is used" do
          assert(pathname == fixture.current_dir_filepath)
        end
      end

      context "Source is a Filename" do
        pathname = fixture.canonical('some_file.json')

        test "The current working directory is used" do
          assert(pathname == fixture.working_dir_filepath('some_file.json'))
        end
      end

      context "Source Is Not Specified" do
        pathname = fixture.canonical(nil)

        test "The default directory and the default filename are used" do
          assert(pathname == fixture.working_dir_filepath)
        end
      end

      context "Source includes both a directory and filename" do
        pathname = fixture.canonical('some_dir/some_file.json')

        test "The source is used" do
          assert(pathname == 'some_dir/some_file.json')
        end
      end
    end
  end
end
