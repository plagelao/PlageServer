require '../server/request_parser.rb'

class Request

  def initialize(options)
    @request_string = options[:request]
    @parse = options[:parse]
  end

  def response
    @parse.parse @request_string do |application|
      return do_get application
    end
    bad_request
  end

  def do_get(application)
    "HTTP/1.1 200 OK\r\n\r\nYou asked for #{application}"
  end

  def bad_request()
    "HTTP/1.1 400 Bad Request\r\n\r\n"
  end
end
