module DomoscioRails
  class Resource
    class << self
      def class_name
        name.split('::')[-1]
      end
      def url(id = nil, util_name = nil, on_self = nil )
        if self == Resource
          raise NotImplementedError.new('Resource is an abstract class. Do not use it directly.')
        end
        build_url = "/v#{DomoscioRails.configuration.version}/instances/#{DomoscioRails.configuration.client_id}"
        if !on_self
          build_url << "/#{class_name.underscore}s"
          if util_name
            build_url << "/#{util_name}"
          end
          if id
            build_url << "/#{CGI.escape(id.to_s)}"
          end
        end
        return build_url  
      end
    end
  end
end