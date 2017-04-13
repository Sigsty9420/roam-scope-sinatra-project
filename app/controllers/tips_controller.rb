class TipsController < ApplicationController

  get '/tips/new' do
    if logged_in?
      @cities = City.all
      @categories = []
      Tip.all.each do |tip|
        @categories << tip.category
      end
      erb :"/tips/new"
    else
      redirect "/login"
    end
  end

  post '/tips' do

  end

end
