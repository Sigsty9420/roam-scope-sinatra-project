class CitiesController < ApplicationController


  get '/cities' do
    @cities = City.all.sort_by {|city| city[:name] }
    erb :'/cities/index'
  end

  get '/cities/new' do
    if logged_in?
      erb :"/cities/new"
    else
      flash[:message] = "You need to login first."
      redirect "/login"
    end
  end

  get '/cities/:slug' do
    @city = City.find_by_slug(params[:slug])
    @tips = @city.tips
    @tips = @tips.sort_by {|tip| tip[:votes]}.reverse
    erb :'/cities/show'
  end

  post '/cities' do
    @new_city = City.new(name: params[:name], country: params[:country])
    if !City.find_by_slug(@new_city.slug) && params[:name] != "" && params[:country] != ""
      @new_city.save
      redirect to "/cities/#{@new_city.slug}"
    elsif City.find_by_slug(@new_city.slug)
      flash[:message] = "City already exists."
      redirect to "/cities"
    else
      flash[:message] = "Error: Your city name or country fields cannot be left blank."
      redirect to "/cities/new"
    end
  end

  get '/cities/:slug/edit' do
    if logged_in?
      @city = City.find_by_slug(params[:slug])
      erb :'/cities/edit'
    else
      flash[:message] = "You need to login first."
      redirect "/login"
    end
  end

  patch '/cities/:slug' do
    @city = City.find_by_slug(params[:slug])
    if params[:name] != "" && params[:country] != ""
      @city.update(name: params[:name], country: params[:country])
      flash[:message] = "City has been updated."
      redirect to "/cities/#{@city.slug}"
    else
      flash[:message] = "Error: Please make sure city name and country is valid."
      redirect to "/cities/#{@city.slug}/edit"
    end
  end
end
