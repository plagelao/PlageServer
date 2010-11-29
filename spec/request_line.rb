require '../server/plage_server.rb'

describe "RequestLine" do

  it "should be well formed (Starts with a method, is follow by an URI and the protocol version, ends with CRLF, separate every token with an empty space except the CRLF)" do
    RequestLine.new("GET http://www.edendevelopment.es HTTP/1.1\u000D\u000A").should be_well_formed
  end

  it "should not be well formed when it makes no sense" do
    RequestLine.new("hackhackhack").should_not be_well_formed
  end

  it "should not be well formed when the tokens are not separate by empty spaces" do
    RequestLine.new("GEThackhackhack").should_not be_well_formed
  end

  it "should not be well formed if the first token is not a GET" do
    RequestLine.new("hackhackhack GET").should_not be_well_formed
  end

  it "should not be well formed if second token is not a valid http URL" do
    RequestLine.new("GET notAnURI").should_not be_well_formed 
  end

  it "should not be well formed if the third token is not a valid http version" do
    RequestLine.new("GET http://www.edendevelopment.es not_a_valid_http_protocol_version").should_not be_well_formed
  end

  it "should not be well formed if the end of the string is not CRLF" do
    RequestLine.new("GET http://www.edendevelopment.es HTTP/1.1").should_not be_well_formed
  end

end
