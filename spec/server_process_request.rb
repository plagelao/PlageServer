require '../server/request.rb'

describe "Request" do

  it "should response to a valid GET request" do
    Request.new({:request => "GET http://localhost:8081/ HTTP/1.1\r\n\r\n", :parse => RequestParser.new}).response.should == "HTTP/1.1 200 OK\r\n\r\nYou asked for /"
  end

  it "should response with a 400 when a request does not start with a http method" do
    Request.new({:request =>" http://www.edendevelopment.es HTTP/1.1\r\n\r\n", :parse => RequestParser.new}).response.should == "HTTP/1.1 400 Bad Request\r\n\r\n"
  end
  
  it "should response with a 400 if the second word of the request is not a valid http URL" do
    Request.new({:request =>"GET invalid_url HTTP/1.1\r\n\r\n", :parse => RequestParser.new}).response.should ==  "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  it "should response with a 400 if the URL is not followed by HTTP/1.1\r\n" do
    Request.new({:request => "GET http://www.edendevelopment.es HTTP/1.2\r\n\r\n", :parse => RequestParser.new}).response.should == "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  it "should response with a 400 if the request does not end with \r\n" do
    Request.new({:request => "GET http://www.edendevelopment.es HTTP/1.1\r\n", :parse => RequestParser.new}).response.should == "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  it "should process a valid GET request with an URL with the host in a header" do
    Request.new({:request => "GET / HTTP/1.1\r\nHost: localhost:8081\r\n\r\n", :parse => RequestParser.new}).response.should == "HTTP/1.1 200 OK\r\n\r\nYou asked for /"
  end

  it "should process a request from Safari web browser" do
    Request.new({:request => "GET / HTTP/1.1\r\nHost: localhost:8081\r\nUser-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; en-us) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5\r\nAccept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\nAccept-Language: en-us\r\nAccept-Encoding: gzip, deflate\r\nConnection: keep-alive\r\n\r\n", :parse => RequestParser.new}).response.should == "HTTP/1.1 200 OK\r\n\r\nYou asked for /"
  end

end
