class UsersController < ApplicationController

  get '/login' do
    erb :'users/login'
  end

  get '/signup' do
    if logged_in?
      redirect "/"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do

    if !User.find_by(username: params[:username]) && !User.find_by(email: params[:email])
      @user = User.new(username: params[:username], email: params[:email] , password: params[:password])
      if @user.username != "" && @user.email != "" && @user.save
        session[:user_id] = @user.id
        session[:username] = @user.username
        redirect "/"
      else
        redirect "/signup"
      end
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  get '/login' do
    if logged_in?
      redirect "/"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect "/"
    else
      redirect "/signup"
    end
  end

end
