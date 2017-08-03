class UsersController < ApplicationController

  get '/signup' do
    if !signed_in?
      erb :"/users/new"
    else
      redirect("/")
    end
  end

  post '/signup' do
    is_valid = Captcha.is_valid?(request.ip, params)
    user = User.new(params[:user])
    if is_valid && user.save
      session[:user_id] = user.id
      redirect("/")
    else
      redirect back
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
      @author = User.find_by_slug(params[:slug])
      erb :"users/show"
  end
end
