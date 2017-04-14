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
    binding.pry
    if !!params[:category] && !!params[:city] && params[:content] != ""
      @tip = Tip.create(content: params[:content], city_id: params[:city], user_id: session[:user_id], category: params[:category], votes: 1)
      redirect to "/cities/#{@tip.city.slug}"
    else
      redirect to '/tips/new'
    end
  end

  get '/tips/:id/vote' do
    if logged_in?
      @tip = Tip.find(params[:id])
      @city = City.find(@tip.city_id)
      if @tip.user_id.to_i == session[:user_id]
        @tip.votes += 1
        @tip.save
        redirect "/cities/#{@city.slug}"
      else
        redirect "/cities/#{@city.slug}"
      end
    else
      redirect "/login"
    end
  end

  get '/tips/:id/edit' do
    if logged_in?
      @tip = Tip.find(params[:id])
      @cities = City.all
      @categories = []
      Tip.all.each do |tip|
        @categories << tip.category
      end
      @categories = @categories.uniq

      if @tip.user_id.to_i == session[:user_id]
        erb :'tips/edit'
      else
        redirect "/cities/#{@tip.city.slug}"
      end
    else
      redirect "/login"
    end
  end

  patch '/tips/:id' do
    @tip = Tip.find(params[:id])
    @tip.update(content: params[:content], city_id: params[:city], category: params[:category], votes: 1)
    redirect "/cities/#{@tip.city.slug}"
  end
end
