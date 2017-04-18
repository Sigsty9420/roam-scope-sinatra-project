class CitiesController < ApplicationController


  get '/cities' do
    @cities = City.all.sort_by {|city| city[:name] }
    erb :'/cities/index'
  end

  get '/cities/new' do
    erb :"/cities/new"
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
      flash[:message] = "New city succesfully created."
      redirect to "/cities/#{@new_city.slug}"
    elsif City.find_by_slug(@new_city.slug)
      flash[:message] = "City already exists."
      redirect to "/cities"
    else
      flash[:message] = "Input error. Your city name or country fields cannot be left blank."
      redirect to "/cities/new"
    end
  end

  get '/cities/:slug/edit' do
    @city = City.find_by_slug(params[:slug])
    erb :'/cities/edit'
  end

  patch '/cities/:slug' do
    @city = City.find_by_slug(params[:slug])
    if params[:name] != "" && params[:country] != ""
      @city.update(name: params[:name], country: params[:country])
      flash[:message] = "City has been updated."
      redirect to "/cities/#{@city.slug}"
    else
      flash[:message] = "Input error. Please make sure city name and country are valid."
      redirect to "/cities/#{@city.slug}/edit"
    end
  end
end
