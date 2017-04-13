class CitiesController < ApplicationController

  get '/cities' do
    @cities = City.all.uniq.sort_by {|city| city[:name] }
    erb :'/cities/index'
  end

  get '/cities/new' do
    erb :"/cities/new"
  end

  get '/cities/:slug' do
    @city = City.find_by_slug(params[:slug])
    @tips = @city.tips
    erb :'/cities/show'
  end

  post '/cities' do
    @new_city = City.new(name: params[:name], country: params[:country])
    if !City.find_by_slug(@new_city.slug) && params[:name] != "" && params[:country] != ""
      @new_city.save
      redirect to "/cities/#{@new_city.slug}"
    else
      redirect to "/cities"
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
      redirect to "/cities/#{@city.slug}"
    else
      redirect to "/cities/#{@city.slug}/edit"
    end
  end
end
