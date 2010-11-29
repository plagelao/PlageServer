require './server/plage_server.rb'

describe "RequestLine" do

  it "should begin with a GET method token" do
    get_request_line = 'GET'
    RequestLine.new(get_request_line).is_a_get?.should be_true 
  end

  it "should end with CRLF" do
    get_request_line = 'GET CRLF'
    RequestLine.new(get_request_line).ends_with_crlf?.should be_true
  end
end
