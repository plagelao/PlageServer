require '../server/request_parser.rb'
require 'URI'

class Server

  def responseTo(request)
    @words = request.split
    do_method(request)
  end

  def do_method(request)
    RequestParser.new.parse(request) do |application|
     return do_get()
    end
    "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  def do_get()
    "HTTP/1.1 200 OK\r\n\r\n"
  end

end
