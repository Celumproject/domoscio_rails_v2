module DomoscioRails
  # @abstract
  class Resource
    class << self
      def class_name
        name.split('::')[-1]
      end

      def url(id = nil, nested_model = nil)
        if self == Resource
          raise NotImplementedError.new('Resource is an abstract class. Do not use it directly.')
        end
        
        build_url = "/v1/companies/#{DomoscioRails.configuration.client_id}"
        build_url << "/#{class_name.underscore}s"
        if id
          build_url << "/#{CGI.escape(id.to_s)}"
        end
        return build_url  
      end
    end
  end
end
