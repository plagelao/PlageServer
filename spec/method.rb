require '../server/http_method.rb'

describe "PlageUrl" do

  it "should be valid if it is a GET" do
    HttpMethod.new('GET').should be_valid
  end

end
