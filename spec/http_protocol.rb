require '../server/http_protocol.rb'

describe "HttpProtocol" do

  it "should be valid if it is HTTP/1.1" do
    HttpProtocol.valid?('HTTP/1.1').should be_true
  end

  it "should be false in any other case" do
    HttpProtocol.valid?('HTTP/5.0').should be_false
  end
end
