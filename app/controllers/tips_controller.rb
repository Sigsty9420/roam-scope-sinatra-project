class TipsController < ApplicationController

  get '/tips/new' do
    if logged_in?
      erb :"/tips/new"
    else
      redirect "/login"
    end
  end

  post '/tips' do
    
  end

end
