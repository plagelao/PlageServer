require '../server/request_parser.rb'

describe "RequestParser" do

  it "should parse a request with an absolute URI in its request line" do
    app = ""
    RequestParser.new.parse "GET http://localhost:8081/ HTTP/1.1\r\n\r\n" do |application|
      app = application
    end
    app.should == '/'
  end

  it "should parse a request with an absolute path of the uri in the request" do
    app = ""
    RequestParser.new.parse "GET / HTTP/1.1\r\nHost: localhost:8081\r\n\r\n" do |application|
      app = application
    end
    app.should == '/'
  end

  it "should not yield if the request does not start with a GET" do
    app = ""
    RequestParser.new.parse(" http://www.edendevelopment.es HTTP/1.1\r\n\r\n") do |application|
      app = application
    end
    app.should == ''
  end
end


