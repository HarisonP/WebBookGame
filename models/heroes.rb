class Models

  class Heroes
    class <<self
      def all_users_heroes(user_id:)
        p user_id
        db = Models.connect_to_db
        heroes = db['heroes'].find(user_id)
        p heroes
      end
    end
  end
end