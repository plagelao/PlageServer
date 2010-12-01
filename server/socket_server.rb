require '../server/server.rb'
require 'socket'

class SocketServer

  def start
    @server_socket = TCPServer.new('localhost', 8081)
    client = @server_socket.accept
    request = client.recv(1024)
    client.send(Server.new.responseTo(request), Socket::MSG_DONTROUTE)
    client.close
  end

  def stop
    @server_socket.close
  end
end
