$: << File.expand_path(File.dirname(__FILE__))
require 'server/socket_server'

SocketServer.new.start
