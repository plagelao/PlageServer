require '../server/plage_url.rb'

describe "PlageUrl" do

  it "should be valid if it is an http URL" do
    PlageUrl.new('http://localhost:8080/index?a=0').should be_valid
  end

  it "should not be valid if it is not an http URL" do
    PlageUrl.new('mailto:plagelao@gmail.com?Subject=hello&body=world').should_not be_valid
  end
end
