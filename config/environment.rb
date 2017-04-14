require 'bundler/setup'
Bundler.require(:default, :development, :production)
ENV['SINATRA_ENV'] ||= "development"

configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end

configure :production do
  db =  URI.parse(ENV['DATABASE_URL'] || 'postgres_database_url')
  db =  'postgres://yryiiwfaozdlsr:79c1d4b8dd0b1b0c8118d4bf1bddd8a8e06452d5a836c5faa4916d82069bdb5c@ec2-54-225-182-108.compute-1.amazonaws.com:5432/da6hn1dtao4plk'

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'UTF8'

  )
end

require_relative '../app/controllers/application_controller.rb'
require_all 'app'
set :public_folder, File.dirname(__FILE__) + '/public'
