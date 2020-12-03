module DomoscioRails
  # Generic error superclass for MangoPay specific errors.
  class Error < StandardError
  end

  # Error Message from AdaptiveEngine
  class ResponseError < Error
    attr_reader :request_url, :code, :details, :body, :request_params
    def initialize(request_url, code, details, body, request_params)
      @request_url, @code, @details, @body, @request_params = request_url, code, details, body, request_params
      super(message) if message
    end
    def message; @details.dig(:error, :message) || @details; end
  end

  # ProcessingError from DomoscioRails
  class ProcessingError < Error
    attr_reader :request_url, :code, :details, :body, :request_params
    def initialize(request_url, code, details, body, request_params)
      @request_url, @code, @details, @body, @request_params = request_url, code, details, body, request_params
      super(message) if message
    end
    def message; @details.message; end
  end
end