require '../server/http_request.rb'

describe "Request" do

  it "should be valid if starts with a request line, is followed by CRLF" do
    Request.new("GET http://edendevelopment.es HTTP/1.1|u000D\u000A\u000D\u000A").should be_valid
  end

end
