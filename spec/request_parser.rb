require 'server/request_parser'

describe "RequestParser" do

  it "should parse a request with an absolute URI in its request line" do
    application_from("GET http://localhost:8081/ HTTP/1.1\r\n\r\n").should == '/'
  end

  it "should parse a request with an absolute path of the uri in the request" do
    application_from("GET / HTTP/1.1\r\nHost: localhost:8081\r\n\r\n").should == '/'
  end

  it "should not yield if the request does not start with a GET" do
    application_from(" / HTTP/1.1\r\nHost: localhost:8081\r\n\r\n").should == nil
  end

  it "should parse a request with an absolute path of the uri in the request" do
    application_from("GET / HTTP/1.1\r\nHost: localhost:8081\r\n\r\n").should == '/'
  end

   it "should parse a request with an absolute path of the uri in the request diferent than /" do
    application_from("GET /something HTTP/1.1\r\nHost: localhost:8081\r\n\r\n").should == '/something'
  end

  def application_from request
    return RequestParser.new.parse request do |application|
      application.uri
    end
  end
end


