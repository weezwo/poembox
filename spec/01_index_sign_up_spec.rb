require 'spec_helper'

describe ApplicationController do

  describe "Homepage" do
    it "loads the homepage" do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to PoemBox")
    end
  end

  describe "Signup Page" do
    it "loads the signup page" do
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it "displays a signup form" do
      get '/signup'
      expect(last_response.body).to include("<form")
    end

    xit "does not display the signup form when logged in" do
      user = User.create(:username => "skittles123", :password => "rainbows")
      params = {
        :username => "skittles123",
        :password => "rainbows"
      }
      post '/signup', params
      session = {}
      session[:user_id] = user.id
      get '/signup'
      expect(last_response.location).to include('/poems')
    end

    it "creates a new user" do
      params = {
        :username => "skittle",
        :password => "rainbows"
      }
      post '/signup', params
      expect(User.all.count).to eq(1)
    end

    it "requires a user name" do
      params = {
        :username => "",
        :password => "12345"
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it "requires a password" do
      params = {
        :username => "skittlefiend",
        :password => ""
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it "requires a correctly solved captcha" do

    end

    it "redirects user to index on signup" do
      params = {
       :username => "skittles123",
       :password => "rainbows"
      }
      post '/signup', params
      expect(last_response.location).to include("/")
    end
  end
end
