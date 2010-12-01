require '../server/socket_server.rb'
require 'socket'

describe "SocketServer" do

  it "should start listening on port 8081" do
    Thread.start(SocketServer.new) do
      server = SocketServer.new
      server.start
      server.stop 
    end
    client = Client.new
    client.do 8081 do
      client.send("a").should == 1
    end
  end

  it "should response with OK when asked for /" do
    Thread.start(SocketServer.new) do
      server = SocketServer.new
      server.start
      server.stop 
    end
    client = Client.new
    client.do 8081 do
      client.send("GET http://localhost:8081/ HTTP/1.1\r\n\r\n") 
      client.received?("HTTP/1.1 200 OK\r\n\r\n").should be_true
    end
  end

  it "should response with a 400 when an invalida request is submitted" do
    Thread.start(SocketServer.new) do
      server = SocketServer.new
      server.start
      server.stop 
    end
    client = Client.new
    client.do 8081 do
      client.send("invalid request") 
      client.received?("HTTP/1.1 400 Bad Request\r\n\r\n").should be_true
    end
  end
end

class Client

  def do(port)
    sleep 0.2
    @socket = TCPSocket.open('localhost', 8081)
    yield
    @socket.close
  end

  def send message
    @socket.send(message, Socket::MSG_DONTROUTE) 
  end

  def received? message
    @socket.recv(message.length) == message
  end

end
