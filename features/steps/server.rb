require './server/socket_server.rb'

Given /^A PlageServer$/ do
  @server_thread = Thread.start(Server.new) do |server|
    server.start
  end
end

When /^I do a GET REQUEST to \/$/ do
    client = Client.new
    client.connect 8081
    client.send("GET http://localhost:8081/ HTTP/1.1\r\n\r\n") 
end

Then /^I should receive a (\d+) RESPONSE with "([^"]*)" in the body$/ do |arg1, arg2|
    client.received?("HTTP/1.1 200 OK\r\n\r\nHello world!").should be_true
    client.close
    @server_thread.kill
end

class Client

  def connect(port)
    sleep 0.2
    @socket = TCPSocket.open('localhost', port)
  end

  def close
    @socket.close
  end

  def send message
    @socket.send(message, Socket::MSG_DONTROUTE) 
  end

  def received? message
    @socket.recv(message.length) == message
  end

end
