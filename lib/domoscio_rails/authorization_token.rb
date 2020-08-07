module DomoscioRails
  module AuthorizationToken

    class Manager

      class << self
        def storage
          @@storage ||= FileStorage.new
        end

        def storage= (storage)
          @@storage = storage
        end

        def get_token
          token = storage.get
          token = DomoscioRails.configuration.client_passphrase if token.nil?
          token
        end
      end
    end

    class StaticStorage
      def get
        @@token ||= nil
      end

      def store(token)
        @@token = token
      end
    end

    class FileStorage
      require 'yaml'
      @temp_dir

      def initialize(temp_dir = nil)
        @temp_dir = temp_dir || DomoscioRails.configuration.temp_dir
        if !@temp_dir
          raise "Path to temporary folder is not defined"
        end
      end

      def get
        begin
          f = File.open(file_path, File::RDONLY)
          f.flock(File::LOCK_SH)
          txt = f.read
          f.close
          YAML.load(txt) || nil
        rescue Errno::ENOENT
          nil
        end
      end

      def store(token)
        File.open(file_path, File::RDWR|File::CREAT, 0644) do |f|
          f.flock(File::LOCK_EX)
          f.truncate(0)
          f.rewind
          f.puts(YAML.dump(token))
        end
      end

      def file_path
        @temp_dir = DomoscioRails.configuration.temp_dir if @temp_dir != DomoscioRails.configuration.temp_dir
        File.join(@temp_dir, "DomoscioRails.AuthorizationToken.FileStore.tmp")
      end
    end
  end
end