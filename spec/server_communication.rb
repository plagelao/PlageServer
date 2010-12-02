require 'server/socket_server'
require 'socket'

describe "SocketServer" do

  it "should start listening on port 8082" do
    for_each_client_connected do |client|
      client.send("a").should == 1
    end
  end

  it "should response with OK when asked for /" do
    for_each_client_connected do |client|
      client.send("GET / HTTP/1.1\r\nHost: localhost:8082\r\n\r\n") 
      client.received?("HTTP/1.1 200 OK\r\n\r\nYou asked for /").should be_true
    end
  end

  it "should response with a 400 when an invalida request is submitted" do
    for_each_client_connected do |client|
      client.send("invalid request") 
      client.received?("HTTP/1.1 400 Bad Request\r\n\r\n").should be_true
    end
  end

  def for_each_client_connected
    while_server_running do
      2.times do
        client = Client.new
        client.while_connected_to 8082 do
          yield(client)
        end
      end
    end
  end

  def while_server_running
    server = SocketServer.new
    server_thread = Thread.new do
      server.start
    end
    begin
      yield
    ensure
      server.stop
      Thread.kill server_thread
    end
  end
end

class Client

  def while_connected_to(port)
    sleep 0.05
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
