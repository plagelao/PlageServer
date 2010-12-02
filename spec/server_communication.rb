require '../server/socket_server.rb'
require 'socket'

describe "SocketServer" do

  it "should start listening on port 8081" do
    while_server_running do |client|
      client.send("a").should == 1
    end
  end

  it "should response with OK when asked for /" do
    while_server_running do |client|
      client.send("GET http://localhost:8081/ HTTP/1.1\r\n\r\n") 
      client.received?("HTTP/1.1 200 OK\r\n\r\nHello world!").should be_true
    end
  end

  it "should response with a 400 when an invalida request is submitted" do
    while_server_running do |client|
      client.send("invalid request") 
      client.received?("HTTP/1.1 400 Bad Request\r\n\r\n").should be_true
    end
  end

  def while_server_running
    server = SocketServer.new
    server_thread = Thread.new do
      server.start
    end
    begin
      client = Client.new
      client.do 8082 do
        yield(client)
      end
    ensure
      server.stop
      Thread.kill server_thread
    end
  end
end

class Client

  def do(port)
    sleep 0.2
    @socket = TCPSocket.open('localhost', port)
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
