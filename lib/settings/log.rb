class Settings
  class Log < ::Log
    def tag!(tags)
      tags << :settings
      tags << :library
      tags << :verbose
    end
  end
end
