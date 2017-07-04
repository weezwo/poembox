require './config/environment'
require 'net/http'
require 'json'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "9077am4k3w4y"
  end

  get '/' do
    erb :index
  end

  helpers do
    def signed_in?
      !!session[:user_id]
    end

    def current_user
      if signed_in?
        User.find_by_id(session[:user_id])
      end
    end
  end
end
