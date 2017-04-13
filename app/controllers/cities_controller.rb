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
    erb :'/cities/show'
  end

  post '/cities' do
    @new_city = City.new(name: params[:name], country: params[:country])
    if !City.find_by_slug(@new_city.slug)
      @new_city.save
      redirect to "/cities/#{@new_city.slug}"
    else
      redirect to "/cities"
    end
  end
end
