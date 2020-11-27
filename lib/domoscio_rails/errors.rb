module DomoscioRails
  # Generic error superclass for MangoPay specific errors.
  class Error < StandardError
  end

  # Error Message from AdaptiveEngine
  class ResponseError < Error
    attr_reader :request_url, :code, :details

    def initialize(request_url, code, details)
      @request_url, @code, @details = request_url, code, details
      super(message) if message
    end
    def message; @details.dig(:error, :message) || @details; end
  end

  # Error Message from DomoscioRails
  class ProcessingError < Error
    attr_reader :request_url, :code, :details
    def initialize(request_url, code, details)
      @request_url, @code, @details = request_url, code, details
      super(message) if message
    end
    def message; @details.message; end
  end
end