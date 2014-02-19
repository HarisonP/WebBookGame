class MyGameBase < Sinatra::Base
  get '/combat' do
    hero = Mage.new(false)
    hero.add_magic_point(improvement_type:'', improvement_name:'damage_reduce_per_turn',how_many: 3)
    p hero
    positions = ['head','body','legs','arms']
    randomer = Random.new
    for i in 0..15
      info = {}
      def_positions = []; 
      def_positions.push(positions[randomer.rand(4)])
      def_positions.push(positions[randomer.rand(4)])
      dmg = randomer.rand(150);
      pos = positions[randomer.rand(4)]
      hero.take_damage(damage:dmg,blocked_positions:def_positions,position:pos, info:info)
      p info  
    end
    p hero.damage_reduce
    p hero
    haml :login
  end
end