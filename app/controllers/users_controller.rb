class UsersController < ApplicationController

  get '/signup' do
    if !signed_in?
      erb :"/users/new"
    else
      redirect("/")
    end
  end

  post '/signup' do
    if params["username"].empty? || params["password"].empty? || User.find_by(username: params["username"])
      redirect("/signup")
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect("/poems")
    end
  end

  get '/login' do
    if !signed_in?
      erb :"/users/login"
    else
      redirect("/")
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect("/poems")
    else
      redirect("/login")
    end
  end

  get '/logout' do
    session.clear
    redirect("/")
  end

  get '/users/:slug' do
    if signed_in?
      @author = User.find_by_slug(params[:slug])
      erb :"users/show"
    end
  end
end
