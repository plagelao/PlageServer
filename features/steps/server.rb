$: << File.expand_path(File.dirname(__FILE__) + "/../..")
require 'server/socket_server'

Given /^A PlageServer$/ do
  @server = SocketServer.new
  @server_thread = Thread.new do
    @server.start
  end
end

When /^I do the REQUEST "([^"]*)"$/ do |request|
    @client = Client.new
    @client.connect 8082
    @client.send(request)
end

Then /^I should receive the RESPONSE "([^"]*)"$/ do |response|
    @client.received?(response).should be_true
    @client.close
    @server.stop
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
    @socket.send(message.gsub("\\n","\n").gsub("\\r","\r"), Socket::MSG_DONTROUTE) 
  end

  def received? message
    @socket.recv(message.gsub("\\n","\n").gsub("\\r","\r").length) == message.gsub("\\n","\n").gsub("\\r","\r")
  end

end
