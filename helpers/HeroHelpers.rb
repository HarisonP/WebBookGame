class HeroHelpers
  class << self
    def generate_bson_to_hero(hero_bson:)
      case hero_bson['properties']['class']
        when 'warrior'
          hero = Warrior.new(true, hero:hero_bson)
        when 'mage'
          hero = Mage.new(true, hero:hero_bson)
        when 'hinter'
          # not implemented
          hero = Warrior.new(true, hero:hero_bson)
        when'rouge'
          # not implemented
          hero = Mage.new(true, hero:hero_bson)
      end
     end
    def generate_random_hero(hero_level:)
        #uglyyy
        names = ["Abaddon", "Alchemist", "Ancient Apparition", "Anti-Mage", "Axe", "Bane", "Batrider", "Beastmaster", "Bloodseeker", "Bounty Hunter", "Brewmaster", "Bristleback", "Broodmother", "Centaur Warrunner", "Chaos Knight", "Chen", "Clinkz", "Clockwerk", "Crystal Maiden", "Dark Seer", "Dazzle", "Death Prophet", "Disruptor", "Doom", "Dragon Knight", "Drow Ranger", "Earth Spirit", "Earthshaker", "Elder Titan"];
        sexes = ['male','female']
        rasses = ['orc', 'elf', 'human']
        classes = ['mage','warrior']
        hero  = nil
        randomer = Random.new
        sex = sexes[randomer.rand(2)]
        rasse = rasses[randomer.rand(3)]
        classe = classes[randomer.rand(2)]
        name = names[randomer.rand(names.size)]
        user_id = "random_hero"
        case classe
          when 'warrior'
            hero = Warrior.new(false, sex:sex, rasse:rasse, classe:classe, name: name, user_id: user_id)
            while hero_level > 1
              hero.levelup();
              hero_level-=1
            end

            strength = hero.properties['unused_skill_points'] - randomer.rand((hero.properties['unused_skill_points']/2).floor)
            hero.properties['strength'] += strength 
            hero.properties['unused_skill_points'] -=strength

            ['dexterity','speed','intelligence'].each do |value|
              if(hero.properties['unused_skill_points'] > 0) 
                 ability = randomer.rand(hero.properties['unused_skill_points'])
                 hero.properties[value] += ability
                 hero.properties['unused_skill_points'] -=ability
              end
            end

            while hero.properties['unused_magic_points'] > 0
              types = ['offensive','defencive'];
              improvement_type = types[randomer.rand(1)];
              if improvement_type == 'offensive'
                improvement_name = 'points'
                while(improvement_name == 'points')
                  rand_key = randomer.rand(hero.offensive_improvements.keys.size)
                  improvement_name = hero.offensive_improvements.keys[rand_key]
                end
                hero.offensive_improvements['points'][improvement_name] += 1 
              else
                improvement_name=''
                while(improvement_name=='points')
                  rand_key = randomer.rand(hero.defencive_improvements.keys.size)
                  improvement_name = hero.defencive_improvements.keys[rand_key]
                end
                hero.defencive_improvements['points'][improvement_name] += 1
              end
              hero.add_magic_points improvement_type:improvement_type,  improvement_name:improvement_name, how_many:1
              hero.properties['unused_magic_points'] -=1
            end
            
          when 'mage'
            hero = Mage.new(false, sex:sex, rasse:rasse, classe:classe, name: name, user_id: user_id)
            while hero_level > 1
              hero.levelup();
              hero_level-=1
            end

            intelligence = hero.properties['unused_skill_points'] - randomer.rand((hero.properties['unused_skill_points']/2).floor)
            hero.properties['intelligence'] += intelligence 
            hero.properties['unused_skill_points'] -=intelligence

            ['dexterity','speed','intelligence'].each do |value|
              if(hero.properties['unused_skill_points'] > 0) 
                 ability = randomer.rand(hero.properties['unused_skill_points'])
                 hero.properties[value] += ability
                 hero.properties['unused_skill_points'] -=ability
              end
            end

            while hero.properties['unused_magic_points'] > 0
              types = ['offensive','defencive'];
              improvement_type = types[randomer.rand(1)];
              if improvement_type == 'offensive'
                improvement_name = 'points'
                while(improvement_name == 'points')
                  rand_key = randomer.rand(hero.offensive_improvements.keys.size)
                  improvement_name = hero.offensive_improvements.keys[rand_key]
                end
                hero.offensive_improvements['points'][improvement_name] += 1 
              else
                improvement_name = 'points'
                while(improvement_name=='points')
                  rand_key = randomer.rand(hero.defencive_improvements.keys.size)
                  improvement_name = hero.defencive_improvements.keys[rand_key]
                end
                hero.defencive_improvements['points'][improvement_name] += 1
              end
              hero.add_magic_points improvement_type:improvement_type,  improvement_name:improvement_name, how_many:1
              hero.properties['unused_magic_points'] -=1
            end

          when 'hinter'
            # not implemented
            hero = Warrior.new(true, hero:hero_bson)
          when'rouge'
            # not implemented
            hero = Mage.new(true, hero:hero_bson)
        end
        hero
    end

  end

end
