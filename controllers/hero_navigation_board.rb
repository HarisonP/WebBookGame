class MyGameBase < Sinatra::Base
  get '/heroes-navigation' do
    heroes = Models::Heroes.all_users_heroes(db: settings.db, user_id: session['user_id'])
    haml :hero_navigation, {locals:{user_heroes:heroes}}
  end

  get '/hero-creaton' do
    haml :hero_creation
  end
  post '/hero-creaton' do
    created_hero = nil
    p params['class']
    # p Mage.new
    case params['class']
      when 'warrior'
        created_hero = Warrior.new(false,params['sex'], params['rasse'], params['class'], params['hero_name'],session['user_id'])
      when 'mage'
        created_hero = Mage.new(false,params['sex'], params['rasse'], params['class'], params['hero_name'],session['user_id'])
    end
      p created_hero
      created_hero.save_hero db:settings.db
      redirect '/heroes-navigation'
  end
  post '/delete-hero' do 
    Models::Heroes.delete_hero(db:settings.db, hero_id: params['hero_for_deletion'], collection: "heroes")
    'success'
  end
end