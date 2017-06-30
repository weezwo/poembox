require './config/environment'

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

end
