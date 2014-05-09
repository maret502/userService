require File.dirname(__FILE__) + '/../service'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
set :environment, :test
Test::Unit::TestCase.send :include,  Rack::Test::Methods

def app
    Sinatra::Application
end

describe "service" do
  before(:each) do
    User.delete_all
  end

  describe "GET on /api/v1/users/:id" do
    before (:each) do
      User.create(
        :name => "monica",
        :email => "monica@maret.io",
        :password => "redcap",
        :bio => "web dev")
    end

    it "should return a user by name" do
      get '/api/v1/users/monica'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes["name"].should == "monica"
    end

    it "should return a user with an email" do
      get '/api/v1/users/monica'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes["email"].should == "monica@maret.io"
    end

  it "should not return a user's password" do
    get '/api/v1/users/monica'
    last_response.should be_ok
    attributes = JSON.parse(last_response.body)
    attributes.should_not have_key("password")
  end

  it "should return a user with a bio" do
    get '/api/v1/users/monica'
    last_response.should be_ok
    attributes["bio"].should == "web dev"
  end

  it "should return a 404 for a user that doesn't exist" do
    get '/api/v1/users/foo'
    last_response.status.should == 404
  end
end

  describe "POST on /api/v1/users" do
    it "should create a user" do
      post '/api/v1/users', {
          :name     => "sophie",
          :email    => "yt@502.io",
          :password =>  "holla",
          :bio      =>  "astrologer"}.to_json
      last_response.should be_ok
      get '/api/v1/users/sophie'
      attributes = JSON.parse(last_response.body)
      attributes["name"].should == "sophie"
      attributes["email"].should == "yt@502.io"
      attributes["bio"].should == "astrologer"
    end
  end

  describe "PUT on /api/v1/users/:id" do
  it "should update a user" do
      User.create(
          :name => "alice",
          :email  => "empty.response.header@gmail.com",
          :password => "whatever",
          :bio  => "black magician")
      put '/api/v1/users/alice', {
          :bio => "philosopher"}.to_json
      last_response.should be_ok
    get '/api/v1/users/alice'
    attributes = JSON.parse(last_response.body)
    attrubutes["bio"].should == "philosopher"
  end
end

end