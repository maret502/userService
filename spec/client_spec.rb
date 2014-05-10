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

it "should create a user" do
  user = User.create ({
      :name => "sophie",
      :email => "yt@502.io",
      :password => "holla"})
  user["name"].should == "sophie"
  user["email"].should == "yt@502.io"
  User.find_by_name("sophie").should == user
end

it "should update a user" do
  user = User.update("monica", {:bio => "web dev and history nerd"})
  user["name"].should == "monica"
  user["bio"].should == "web dev and history nerd"
  User.find_by_name("monica").should == user
end

it "should destroy a user" do
  User.destroy("jerk").should == true
  User.find_by_name("jerk").should be_nil
end

it "should verify login credentials" do
  user = User.login("monica", "redcap")
  user["name"].should == "monica"
end

it "should return nil with invalid credentials" do
  User.login("monica", "holla").should be_nil
end
end