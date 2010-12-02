require 'server/request'
require 'socket'

class SocketServer

  def start
    wait_for_request do |request|
      Request.new({:request => request, :parse => RequestParser.new}).response
    end
  end

  def stop
    @server_socket.close
  end

  def wait_for_request
    @server_socket = TCPServer.new('localhost', 8082)
    loop do
      client = @server_socket.accept
      client.send(yield(client.recv 1024), Socket::MSG_DONTROUTE)
      client.close
    end
  end

end
