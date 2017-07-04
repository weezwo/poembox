class UsersController < ApplicationController

  get '/signup' do
    if !signed_in?
      erb :"/users/new"
    else
      redirect("/")
    end
  end

  post '/signup' do
    res = Net::HTTP.post_form(
    URI.parse('http://www.google.com/recaptcha/api/verify'),
    {
      'privatekey' => '6Ldt5icUAAAAADMgPkDRpb5S3sZWvDoSH0Va7Dax',
      'remoteip'   => request.ip,
      'challenge'  => params[:recaptcha_challenge_field],
      'response'   => params[:recaptcha_response_field]
    }
    )

    success, error_key = res.body.lines.map(&:chomp)

    if success
      if params["username"].empty? || params["password"].empty? || User.find_by(username: params["username"])
        redirect("/signup")
      else
        user = User.create(username: params["username"], password: params["password"])
        session[:user_id] = user.id
        redirect("/poems")
      end
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
    if signed_in?
      @author = User.find_by_slug(params[:slug])
      erb :"users/show"
    end
  end
end
