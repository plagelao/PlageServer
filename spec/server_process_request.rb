require '../server/server.rb'

describe "Server" do

  it "should process a valid GET request" do
    Server.new.responseTo("GET http://localhost:8081/ HTTP/1.1\r\n\r\n").should == "HTTP/1.1 200 OK\r\n\r\n"
  end

  it "should response with a 400 when a request does not start with a http method" do
    Server.new.responseTo(" http://www.edendevelopment.es HTTP/1.1\r\n\r\n").should == "HTTP/1.1 400 Bad Request\r\n\r\n"
  end
  
  it "should response with a 400 if the second word of the request is not a valid http URL" do
    Server.new.responseTo("GET invalid_url HTTP/1.1\r\n\r\n").should ==  "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  it "should response with a 400 if the URL is not followed by HTTP/1.1\r\n" do
    Server.new.responseTo("GET http://www.edendevelopment.es HTTP/1.2\r\n\r\n").should == "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  it "should response with a 400 if the request does not end with \r\n" do
    Server.new.responseTo("GET http://www.edendevelopment.es HTTP/1.1\r\n").should == "HTTP/1.1 400 Bad Request\r\n\r\n"
  end

  it "should process a valid GET request with an URL with the host in a header" do
    Server.new.responseTo("GET / HTTP/1.1\r\nHost: localhost:8081\r\n\r\n").should == "HTTP/1.1 200 OK\r\n\r\n"
  end

  it "should process a valid GET request with an URL with the host in a header" do
    Server.new.responseTo("GET / HTTP/1.1\r\nHost: localhost:8081\r\nUser-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; en-us) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5\r\nAccept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\nAccept-Language: en-us\r\nAccept-Encoding: gzip, deflate\r\nConnection: keep-alive\r\n\r\n").should == "HTTP/1.1 200 OK\r\n\r\n"
  end

end
