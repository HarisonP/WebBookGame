class MyGameBase < Sinatra::Base
  get '/fight' do 
    @hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']))
    hero = HeroHelpers.generate_bson_to_hero(hero_bson:@hero);
    @hero_chosen = true

    oponent = session['possible_oponent']
    @incombat = true
    @oponent = oponent
    haml :town
    # redirect '/hero-chosen/' + session['hero_chosen']
  end

  post '/fight' do
    randomer = Random.new
    atack_params = params.keys
    @hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']))
    hero = HeroHelpers.generate_bson_to_hero(hero_bson:@hero)

    oponent = session['possible_oponent']
    users_damage = 0
    case atack_params[0]
      when 'first_spell'
          users_damage = hero.first_spell
      when 'second_spell'
          users_damage = hero.second_spell
      when 'third_spell'
          user_damage = hero.third_spell
      when 'ultimate'
          user_damage = hero.utlimate
    end
      positions = ['head','body','arms','legs']
      blocked_position = []
      blocked_position.push(positions[randomer.rand(4)])
      blocked_position.push(positions[randomer.rand(4)])
      position = atack_params[1].split('_')[1]
      oponent.take_damage(damage:users_damage, blocked_positions:blocked_position, position:position,info:{})
      session['possible_oponent'] = oponent
      # bots turn to atack
      bots_damage = 0
      case randomer.rand(4)
        when 1
            bots_damage = oponent.first_spell
        when 2
            bots_damage = oponent.second_spell
        when 3
            bots_damage = oponent.third_spell
        when 4
            bots_damage = oponent.utlimate
      end
        def_positions = []
        def_positions.push(atack_params[2].split('_')[1])
        def_positions.push(atack_params[3].split('_')[1])
        bot_atack_position = positions[randomer.rand(4)]
        hero.take_damage(damage:bots_damage, blocked_positions:def_positions, position:bot_atack_position, info:{})
        p bots_damage
        p bot_atack_position
        p hero.properties['health']
        hero.update_hero db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']),hero:hero

        redirect '/fight'
      end

  get '/hero-chosen/:id' do |id|
    @hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(id))
    session['hero_chosen'] = id
    hero = HeroHelpers.generate_bson_to_hero(hero_bson:@hero);
    @hero_chosen = true

    oponent = HeroHelpers.generate_random_hero hero_level: hero.properties['level']

    @possible_oponent = oponent
    session['possible_oponent'] = @possible_oponent
    haml :town
  end


  get "/levelup" do
    @hero = Models::Heroes.find_hero(db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']))
    hero = HeroHelpers.generate_bson_to_hero(hero_bson:@hero);
    hero.levelup()
    hero.update_hero db:settings.db, user_id:session['user_id'], hero_id:BSON::ObjectId(session['hero_chosen']), hero:hero
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