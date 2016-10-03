require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base
  

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end




  get "/" do
    erb :'/users/index'
  end

  get "/users/signup" do
    erb :'/users/signup'
  end

  post "/users/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect '/users/failure'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/users/login'
    end

  end

  get '/users/account' do
    @user = User.find(session[:user_id])
    erb :'/users/account'
  end


  get "/users/login" do
    erb :'users/login'
  end

  post "/users/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/account"
    else
      redirect to "/users/failure"
    end
  end

  get "/users/success" do
    if logged_in?
      erb :'/users/success'
    else
      redirect "/users/login"
    end
  end

  get "/users/failure" do
    erb :'/users/failure'
  end

  get "/users/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end