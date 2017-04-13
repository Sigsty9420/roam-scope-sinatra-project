class TipsController < ApplicationController

  get '/tips/new' do
    if logged_in?
      @cities = City.all
      @categories = []
      Tip.all.each do |tip|
        @categories << tip.category
      end
      @categories = @categories.uniq
      erb :"/tips/new"
    else
      redirect "/login"
    end
  end

  post '/tips' do
    if !!params[:category] && !!params[:city] && params[:content] != ""
      @tip = Tip.create(content: params[:content], city_id: params[:city], user_id: session[:user_id], category: params[:category], votes: 1)
      redirect to "/cities/#{@tip.city.slug}"
    else
      redirect to '/tips/new'
    end
  end

end
