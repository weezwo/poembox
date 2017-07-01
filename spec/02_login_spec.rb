require 'spec_helper'

describe ApplicationController do
  describe "Login Page" do
    it "loads the login page" do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it "displays the login form" do
      get '/login'
      expect(last_response.body).to include("<form")
    end

    it "displays the login form only when a user is not logged it" do
      user = User.create(:username => "skittles123", :password => "rainbows")
      params = {
        :username => "skittles123",
        :password => "rainbows"
      }
      post '/login', params
      session = {}
      session[:user_id] = user.id
      get '/login'
      expect(last_response.location).to include('/poems')
    end

    it "requires valid details for login" do
      params = {
        :username => "skittles123",
        :password => "rainbows"
      }
      post '/login', params
      expect(last_response.location).to include('/login')
    end

  end
end
