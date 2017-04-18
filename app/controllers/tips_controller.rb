class TipsController < ApplicationController

  get '/tips/new' do
    check_for_authenticated_user!
    @cities = City.all
    @categories = []
    Tip.all.each do |tip|
      @categories << tip.category
    end
    @categories = @categories.uniq
    erb :"/tips/new"
  end

  post '/tips' do
    if !!params[:category] && !!params[:city] && params[:content] != ""
      @tip = Tip.create(content: params[:content], city_id: params[:city], user_id: session[:user_id], category: params[:category], votes: 1)
      redirect to "/cities/#{@tip.city.slug}"
    else
      flash[:message] = "Error: Invalid tip entry. Please make sure all fields are filled in correctly."
      redirect to '/tips/new'
    end
  end

  get '/tips/:id/vote' do
    check_for_authenticated_user!
    @tip = Tip.find(params[:id])
    @city = City.find(@tip.city_id)
    if @tip.user_id.to_i != session[:user_id]
      @tip.votes += 1
      @tip.save
      redirect "/cities/#{@city.slug}"
    else
      flash[:message] = "Error: You can't upvote your own tips."
      redirect "/cities/#{@city.slug}"
    end
  end

  get '/tips/:id/edit' do
    check_for_authenticated_user!
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
      flash[:message] = "Error: You can't edit other people's tips."
      redirect "/cities/#{@tip.city.slug}"
    end
  end

  patch '/tips/:id' do
    @tip = Tip.find(params[:id])
    @tip.update(content: params[:content], city_id: params[:city], category: params[:category], votes: 1)
    redirect "/cities/#{@tip.city.slug}"
  end

  get '/tips/:id/delete' do
    check_for_authenticated_user!
    @tip = Tip.find(params[:id])
    if @tip.user_id.to_i == session[:user_id]
      @tip.destroy
      redirect "/cities/#{@tip.city.slug}"
    else
      flash[:message] = "Error: You can't delete other people's tips."
      redirect "/cities/#{@tip.city.slug}"
    end
  end

end
