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
  db =  URI.parse(ENV['DATABASE_URL'] || 'postgres://onmnflldskcbmn:73057b0de4c6beac27b03b64de29fd7ad530d8a75efe872cce17697dc34f10a3@ec2-54-235-153-124.compute-1.amazonaws.com:5432/d9cfm2gjf6a3ne')
#  db =  ''

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
