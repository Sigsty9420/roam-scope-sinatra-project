class CitiesController < ApplicationController

  get '/cities' do
    @cities = City.all.sort_by {|city| city[:name] }
    erb :'/cities/index'
  end

  get '/cities/:slug' do
    @city = City.find_by_slug(params[:slug])
    @tips = @city.tips
    erb :'/cities/show'
  end
end
