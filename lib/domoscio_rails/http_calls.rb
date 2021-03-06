module DomoscioRails
  module HTTPCalls

    module Create
      module ClassMethods
        def create(*id, params)
          id = id.empty? ? nil : id[0]
          DomoscioRails.request(:post, url(id), params)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end

    module Update
      module ClassMethods
        def update(id = nil, params = {})
          DomoscioRails.request(:put, url(id), params)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end

    module UpdateSelf
      module ClassMethods
        def update_self(params = {})
          DomoscioRails.request(:put, url(nil, nil, true), params)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end

    module Fetch
      module ClassMethods
        def fetch(id = nil, params = {})
          DomoscioRails.request(:get, url(id), params)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end

    module Destroy
      module ClassMethods
        def destroy(id = nil, params = {})
          DomoscioRails.request(:delete, url(id), params)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end

    module Util
      module ClassMethods
        def util(id = nil, util_name = nil, params = {})
          DomoscioRails.request(:get, url(id, util_name), params)
        end
        def util_post(id = nil, util_name = nil, params = {})
          DomoscioRails.request(:post, url(id, util_name), params)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
