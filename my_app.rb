require 'rubygems'
require 'sinatra/base'
require 'mongo'
require 'digest/md5'
require 'securerandom'
require 'haml'
require 'json'
  

class MyGameBase < Sinatra::Base

 enable :sessions
 set :root, File.dirname(__FILE__)
 set :views, File.expand_path('../views', __FILE__);
  before do

  end
  
  get '/' do
    redirect '/login', 303
  end
end


Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

class Models
  include Mongo
  extend Mongo
  def self.connect_to_db(name: "web_book_game")
    db = MongoClient.new("localhost", 27017).db(name);
  end
end

PATHS = {
  # '/login, /logout, /register'           => 'authentication',
  # '/heroes-navigation"'       => hero_navigation,
  # '/categories' => MyGame::AuthenticationController,
  # '/expenses'   => MyGame::AuthenticationController,
  # '/report'     => MyGame::AuthenticationController
}


