require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "youwillnevergetthis"
  end

  get '/' do
    @city = City.all.sample
    @tips = @city.tips
    erb :index
  end

end
