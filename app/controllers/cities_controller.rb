class CitiesController < ApplicationController

  get '/cities' do
    @cities = City.all.sort_by {|city| city[:name] }
    erb :'/cities/index'
  end


end
