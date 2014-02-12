class Models
  class <<self
	def register(username:, password:, repeated_password:, email:)
		db = connect_to_db
		users =db['users']
		p users.find({name: 'hari'}).count;
		p username
		p password
		p repeated_password
		p email
	end

	private def connect_to_db(name: "web_book_game")
	  	db = MongoClient.new("localhost", 27017).db(name);
  	end
  end
end