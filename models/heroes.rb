class Models

  class Heroes
    class <<self
      def all_users_heroes(db:,user_id:)
        heroes = db['heroes'].find({user_id: user_id})
        heroes.to_a
      end
      
      def find_hero(db:, user_id:, hero_id:)
        db['heroes'].find_one({_id:hero_id, user_id:user_id})
      end

      def update_hero(db:, collection:, user_id:, hero_id:, update_obj:)
        db[collection].update({_id:hero_id,  user_id:user_id}, {"$set" => {'properties' =>update_obj.properties, 
                                                                          'offensive_improvements'=>update_obj.offensive_improvements,
                                                                          'defencive_improvements' => update_obj.defencive_improvements}})
        "success"
      end
      def save_hero(db:, hero:, collection:)
        hero_for_saving = {user_id:hero.properties['user_id'],name: hero.properties['name'], properties: hero.properties, 
                          defencive_improvements: hero.defencive_improvements,
                          offensive_improvements: hero.offensive_improvements }
        db[collection].insert(hero_for_saving)
      end

      def delete_hero(db:, hero_id:, collection:)
        db[collection].remove({_id: BSON::ObjectId.from_string(hero_id)});
      end
    end
  end
end