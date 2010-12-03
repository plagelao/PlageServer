require 'server/request_parser'

class Request

  def initialize(options)
    @request_string = options[:request]
    @parse = options[:parse]
    @applications = {:tutorial => "<html><head></head>\n<body>\n<h3>\nWelcome to the tutorial\n</h3>\n<p>To add a web page put it in the same directory where the server is running</p></body></html>"}
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
