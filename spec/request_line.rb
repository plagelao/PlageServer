require './server/plage_server.rb'

describe "RequestLine" do

  it "should be well formed (Starts with GET, is follow by an URI and the protocol version, ends with CRLF, separate every token with an empty space except the CRLF)" do
    get_request_line = "GET http://www.edendevelopment.es HTPP/1.1\u000D\u000A"
    RequestLine.new(get_request_line).should be_well_formed
  end

  it "should not be well formed when it makes no sense" do
    RequestLine.new("hackhackhack").should_not be_well_formed
  end

  it "should not be well formed when the tokens are not separate by empty spaces" do
    RequestLine.new("GEThackhackhack").should_not be_well_formed
  end

  it "should not be well formed if there first tiken is not a GET" do
    RequestLine.new("hackhackhack GET").should_not be_well_formed
  end
end
