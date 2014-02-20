class MyGameBase < Sinatra::Base
  get '/hero-chosen/:id' do |id|
    @hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(id))
    session['hero_chosen'] = id
    @hero_chosen = true
    haml :town
  end
  put '/update-hero' do
    hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']))
    new_stats = params['stats'].reduce(0, :+)
    current_stats = hero.properties['strength'] + hero.properties['dexterity'] + hero.properties['speed'] + hero.properties['intelligence'] + hero.properties['unused_skill_points']
    if new_stats <= current_stats
      hero.properties['strength'] = params['stats']['more_strength']
      hero.properties['dexterity'] = params['stats']['more_dexterity']
      hero.properties['speed'] = params['stats']['more_speed']
      hero.properties['intelligence'] = params['stats']['more_intelligence']
      hero.properties['unused_skill_points'] = current_stats - new_stats
    end
    updated_hero = {properties:hero.properties}
    Models::Heroes.update_hero(db: settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_id']), update_obj:updated_hero)
    p hero.properties
    "fua"
  end 
end