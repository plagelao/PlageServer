require '../server/server.rb'

describe "Server" do

  it "should process a valid GET request" do
    Server.new.responseTo("GET http://www.edendevelopment.es HTTP/1.1\r\n\r\n").should == "Hello world"
  end

  it "should response with a 400 when a request does not start with a http method" do
    Server.new.responseTo(" http://www.edendevelopment.es HTTP/1.1\r\n\r\n").should == 400
  end
  
  it "should response with a 400 if the second word of the request is not a valid http URL" do
    Server.new.responseTo("GET invalid_url HTTP/1.1\r\n\r\n").should == 400
  end

  it "should response with a 400 if the URL is not followed by HTTP/1.1\r\n" do
    Server.new.responseTo("GET http://www.edendevelopment.es HTTP/1.2\r\n\r\n").should == 400
  end

  it "should response with a 400 if the request does not end with \r\n" do
    Server.new.responseTo("GET http://www.edendevelopment.es HTTP/1.1\r\n").should == 400
  end
end
