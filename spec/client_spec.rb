describe "client" do
  before(:each) do
    User.base_uri = "http://localhost:3000"
  end

  it "should get a user" do
    user = User.find_by_name("monica")
    user["name"].should == "monica"
    user["email"].should == "monica@maret.io"
    user["bio"].should == "web dev"
  end
  it "should return nil for a user not found" do
    User.find_by_name("elvis").should be_nil
  end
end