class MyGameBase < Sinatra::Base
  get '/hero-chosen/:id' do |id|
    @hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(id))
    session['hero_chosen'] = id
    hero = HeroHelpers.generate_bson_to_hero(hero_bson:@hero);
    # p hero.first_spell
    # p hero.first_spell
    # p hero.first_spell
    info ={}
    # hero.take_damage(damage:10,blocked_positions:['arms','legs'],position:'head',info:info);
    # p info
    p hero
    @hero_chosen = true
    haml :town
  end

  put '/update-hero' do
    bson_hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']))
    hero = HeroHelpers.generate_bson_to_hero(hero_bson:bson_hero);
    if params['stats'].values.map(&:to_i).reduce(:+) <= hero.properties['unused_skill_points']
      params['stats'].each do |key, value|
        int_value = value.to_i
        hero.properties[key] += int_value
        hero.properties['unused_skill_points'] -= int_value
      end
    end

    if params['offensive'].values.map(&:to_i).reduce(:+) + params['defencive'].values.map(&:to_i).reduce(:+) <= hero.properties['unused_magic_points']
      params['offensive'].each do |key, value|
        int_value = value.to_i
        hero.offensive_improvements["points"][key] += int_value
        hero.properties['unused_magic_points'] -= int_value
        hero.add_magic_points(improvement_type:'offensive', improvement_name:key, how_many:int_value)
      end

      params['defencive'].each do |key, value|
        int_value = value.to_i
        hero.defencive_improvements["points"][key] += int_value
        hero.properties['unused_magic_points'] -= int_value
        hero.add_magic_points(improvement_type:'defencive', improvement_name:key, how_many:int_value)
      end

    end
    hero.update_hero db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']), hero:hero
  end
end