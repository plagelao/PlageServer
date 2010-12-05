require 'server/request_parser'

class Request

  def initialize(options)
    @request_string = options[:request]
    @parse = options[:parse]
  end

  def response
    @parse.parse @request_string do |application|
      return application.response
    end
    bad_request
  end

  def bad_request()
    "HTTP/1.1 400 Bad Request\r\n\r\n"
  end
end
