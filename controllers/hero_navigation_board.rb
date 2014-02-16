class MyGameBase < Sinatra::Base
  get '/heroes-navigation' do
    Models::Heroes.all_users_heroes(user_id: session['user_id'])
    haml :hero_navigation
  end

  get '/hero-creaton' do
    haml :hero_creation
  end
  post '/hero-creaton' do
    created_hero = Hero.new(false,params['sex'], params['rasse'], params['class'], params['hero_name'],session['user_id'])
    p params['rasse']
    haml :login
  end
  #helpers ViewHelpers
end