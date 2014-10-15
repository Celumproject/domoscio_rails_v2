module DomoscioRails
  module AuthorizationToken

    class Manager

      class << self
        def storage
          @@storage ||= StaticStorage.new
        end

        def storage= (storage)
          @@storage = storage
        end

        def get_token
          # token = storage.get
          #           if token.nil? || token['timestamp'].nil? || token['timestamp'] <= Time.now
          #             token = DomoscioRails.request(:post, '/api/oauth/token', {}, {}, {}, Proc.new do |req|
          #               cfg = DomoscioRails.configuration
          #               req.basic_auth cfg.client_id, cfg.client_passphrase
          #               req.body = 'grant_type=client_credentials'
          #             end)
          #             token['timestamp'] = Time.now + token['expires_in'].to_i
          #             storage.store token
          #           end
          token = DomoscioRails.configuration.client_passphrase
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
        File.join(@temp_dir, "DomoscioRails.AuthorizationToken.FileStore.tmp")
      end
    end
  end
end