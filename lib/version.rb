require 'pathname'

module ProductStore
  class << self
    def current_version
      if BUILD_VERSION_FILE.exist?
        BUILD_VERSION_FILE.read.chomp
      else
        ENV.fetch('APP_VERSION', MAJOR_VERSION_FILE.read.chomp)
      end
    end
  end

  BUILD_VERSION_FILE = Pathname.getwd.join('VERSION')
  MAJOR_VERSION_FILE = Pathname.getwd.join('MAJOR_VERSION')
  VERSION            = current_version
end
