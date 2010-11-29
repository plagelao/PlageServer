require '../server/http_method.rb'

describe "Http method" do

  it "should be valid if it is a GET" do
    HttpMethod.new('GET').should be_valid
  end

  it "should not be valid if it makes no sense" do
    HttpMethod.new('blablabla').should_not be_valid
  end
end
