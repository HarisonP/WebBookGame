class Models

  class Heroes
    class <<self
      def all_users_heroes(user_id:)
        p user_id
        db = Models.connect_to_db
        heroes = db['heroes'].find({user_id: user_id})
        p heroes
      end
      def save_hero(hero:)
        p hero
        db = Models.connect_to_db
        hero_for_saving = {user_id:hero.properties['user_id'],name: hero.properties['name'], properties: hero.properties, 
                          defencive_improvements: hero.defencive_improvements,
                          offensive_improvements: hero.offensive_improvements }
        db['heroes'].insert(hero_for_saving)
      end
    end
  end
end