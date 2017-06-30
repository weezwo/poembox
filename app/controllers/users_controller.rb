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

  end

  post '/login' do

  end

  get '/logout' do

  end

  get '/users/:slug' do

  end
end
