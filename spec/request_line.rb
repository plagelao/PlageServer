require './server/plage_server.rb'

describe "RequestLine" do

  it "should be well formed (Start with GET, end with CRLF, separate every token with an empty space)" do
    get_request_line = 'GET CRLF'
    RequestLine.new(get_request_line).is_well_formed?.should be_true 
  end
end
