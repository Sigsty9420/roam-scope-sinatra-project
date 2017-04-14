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
  db =  'postgres://nnpxiyorkzznok:e44c22b6b8ae7042470089d4a5cce41a2827224764df355d330f55802d45107f@ec2-54-225-182-108.compute-1.amazonaws.com:5432/d7ku4eunhqs2ck'

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
