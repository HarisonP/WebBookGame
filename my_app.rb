require 'rubygems'
require 'sinatra/base'
require 'mongo'



class MyGameBase < Sinatra::Base
 # include Models
 set :views, File.expand_path('../views', __FILE__);

  before do

  end
  
  get '/' do
    redirect '/login', 303
  end
end


Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

class Models
    extend Mongo
end

PATHS = {
  # '/login, /logout, /register'           => 'AuthenticationController',
  # '/user'       => MyGame::AuthenticationController,
  # '/categories' => MyGame::AuthenticationController,
  # '/expenses'   => MyGame::AuthenticationController,
  # '/report'     => MyGame::AuthenticationController
}


