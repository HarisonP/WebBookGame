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
  end

end
