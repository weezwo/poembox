class UsersController < ApplicationController

  get '/signup' do
    if !signed_in?
      erb :"/users/new"
    else
      redirect("/")
    end
  end

  post '/signup' do

  end

  get '/login' do
    if !signed_in?
      erb :"/users/login"
    else
    end
  end

  post '/login' do

  end

  get '/logout' do

  end

  get '/users/:slug' do
    if signed_in?
      @user = User.find_by_slug(params[:slug])
      erb
    end
  end
end
