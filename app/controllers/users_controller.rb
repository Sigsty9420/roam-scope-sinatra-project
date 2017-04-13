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
    @user = User.create(username: params[:username], email: params[:email] , password: params[:password])

    if @user.save && @user.username != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect "/"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

end
