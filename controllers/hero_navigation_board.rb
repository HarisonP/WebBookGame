class MyGameBase < Sinatra::Base
  get '/heroes-navigation' do
    Models::Heroes.all_users_heroes(user_id: session['user_id'])
    haml :hero_navigation
  end
  get '/hero-creaton' do
    haml :hero_creation
  end
  #helpers ViewHelpers
end