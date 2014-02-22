class MyGameBase < Sinatra::Base
  get '/test/randomHero' do
    randomer = Random.new
    hero = HeroHelpers.generate_random_hero hero_level:1
    positions = ['head','body','arms','legs']
    p "HERO LVL 1:"
    1.upto(15) do
      info = {}
      def_positions = []; 
      def_positions.push(positions[randomer.rand(4)])
      def_positions.push(positions[randomer.rand(4)])
      dmg = randomer.rand(200);
      pos = positions[randomer.rand(4)]
      hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
      p "Expected Results: damage_taken < 200"
      p "Damage Taken: " 
      p info['damage_taken']
      p "Expected Damage Done(first_spell): > 25"
      p hero.first_spell
      p "======================================="
    end

    hero = HeroHelpers.generate_random_hero hero_level:3
    p "HERO LVL 3:"
    p "**************************************************************************"
    1.upto(15) do
      info = {}
      def_positions = []; 
      def_positions.push(positions[randomer.rand(4)])
      def_positions.push(positions[randomer.rand(4)])
      dmg = randomer.rand(150);
      pos = positions[randomer.rand(4)]
      hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
      p "Expected Results: damage_taken < 150"
      p "Damage Taken: " 
      p info['damage_taken']
      p "Expected Damage Done (ultimate): > 300"
      p hero.ultimate
      p "======================================="
    end


    hero = HeroHelpers.generate_random_hero hero_level:15
    p "HERO LVL 15:"
    p "**************************************************************************"
    1.upto(15) do
      info = {}
      def_positions = []; 
      def_positions.push(positions[randomer.rand(4)])
      def_positions.push(positions[randomer.rand(4)])
      dmg = randomer.rand(150);
      pos = positions[randomer.rand(4)]
      hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
      p "Expected Results: damage_taken < 150"
      p "Damage Taken: "
      p info['damage_taken']
      p "Expected Damage Done (first): > 250 < second/2"
      p hero.first_spell
      p "Expected Damage Done (second): > 600 ultimate<"
      p hero.second_spell
      p "Expected Damage Done (ultimate): > 1300  2000<"
      p hero.ultimate
      p "======================================="
    end

    200
  end

   get '/test/warrior' do
      randomer = Random.new
      hero = HeroHelpers.generate_random_hero hero_level:1
      while hero.properties['class'] != 'warrior'
        hero = HeroHelpers.generate_random_hero hero_level:1
      end

      positions = ['head','body','arms','legs']
      p "Warrior LVL 1:"
      1.upto(15) do
        info = {}
        def_positions = []; 
        def_positions.push(positions[randomer.rand(4)])
        def_positions.push(positions[randomer.rand(4)])
        dmg = randomer.rand(200);
        pos = positions[randomer.rand(4)]
        hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
        p "Expected Results: damage_taken < 200"
        p "Damage Taken: " 
        p info['damage_taken']
        p "Expected Damage Done(first_spell): > 25"
        p hero.first_spell
        p "======================================="
      end

      hero = HeroHelpers.generate_random_hero hero_level:3
      while hero.properties['class'] != 'warrior'
        hero = HeroHelpers.generate_random_hero hero_level:3
      end
      p "Warrior LVL 3:"
      p "**************************************************************************"
        1.upto(15) do
        info = {}
        def_positions = []; 
        def_positions.push(positions[randomer.rand(4)])
        def_positions.push(positions[randomer.rand(4)])
        dmg = randomer.rand(150);
        pos = positions[randomer.rand(4)]
        hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
        p "Expected Results: damage_taken < 150"
        p "Damage Taken: " 
        p info['damage_taken']
        p "Expected Damage Done (ultimate): > 300"
        p hero.ultimate
        p "======================================="
      end


      hero = HeroHelpers.generate_random_hero hero_level:15
      while(hero.properties['class'] != 'warrior')
        hero = HeroHelpers.generate_random_hero hero_level:15
      end

      p "Warrior LVL 15:"
      p "**************************************************************************"
      1.upto(15) do
        info = {}
        def_positions = []; 
        def_positions.push(positions[randomer.rand(4)])
        def_positions.push(positions[randomer.rand(4)])
        dmg = randomer.rand(150);
        pos = positions[randomer.rand(4)]
        hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
        p "Expected Results: damage_taken < 150"
        p "Damage Taken: "
        p info['damage_taken']
        p "Expected Damage Done (first): > 250"
        p hero.first_spell
        p "Expected Damage Done (second): > 600"
        p hero.second_spell
        p "Expected Damage Done (ultimate): > 1000"
        p hero.ultimate
        p "======================================="
      end

      200
    end


  get '/test/mage' do
      randomer = Random.new
      hero = HeroHelpers.generate_random_hero hero_level:1
      while hero.properties['class'] != 'mage'
        hero = HeroHelpers.generate_random_hero hero_level:1
      end

      positions = ['head','body','arms','legs']
      p "Mage LVL 1:"
      1.upto(15) do
        info = {}
        def_positions = []; 
        def_positions.push(positions[randomer.rand(4)])
        def_positions.push(positions[randomer.rand(4)])
        dmg = randomer.rand(200);
        pos = positions[randomer.rand(4)]
        hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
        p "Expected Results: damage_taken < 200"
        p "Damage Taken: " 
        p info['damage_taken']
        p "Expected Damage Done(first_spell): > 25"
        p hero.first_spell
        p "======================================="
      end

      hero = HeroHelpers.generate_random_hero hero_level:3
      while hero.properties['class'] != 'mage'
        hero = HeroHelpers.generate_random_hero hero_level:3
      end
      p "Mage LVL 3:"
      p "**************************************************************************"
        1.upto(15) do
        info = {}
        def_positions = []; 
        def_positions.push(positions[randomer.rand(4)])
        def_positions.push(positions[randomer.rand(4)])
        dmg = randomer.rand(150);
        pos = positions[randomer.rand(4)]
        hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
        p "Expected Results: damage_taken < 150"
        p "Damage Taken: " 
        p info['damage_taken']
        p "Expected Damage Done (ultimate): > 300"
        p hero.ultimate
        p "======================================="
      end


      hero = HeroHelpers.generate_random_hero hero_level:15
      while(hero.properties['class'] != 'mage')
        hero = HeroHelpers.generate_random_hero hero_level:15
      end

      p "Mage LVL 15:"
      p "**************************************************************************"
      1.upto(15) do
        info = {}
        def_positions = []; 
        def_positions.push(positions[randomer.rand(4)])
        def_positions.push(positions[randomer.rand(4)])
        dmg = randomer.rand(150);
        pos = positions[randomer.rand(4)]
        hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
        p "Expected Results: damage_taken < 150"
        p "Damage Taken: "
        p info['damage_taken']
        p "Expected Damage Done (first): > 250"
        p hero.first_spell
        p "Expected Damage Done (second): > 600"
        p hero.second_spell
        p "Expected Damage Done (ultimate): > 1000"
        p hero.ultimate
        p "======================================="
      end

      200
    end
end