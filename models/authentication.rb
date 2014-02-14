class Models

  class Authentication
	  class <<self
	  	def usernameExists(db:,username:)
	  		users =db['users'];
	  		users.find({username: username}).count != 0
	  	end

	    def register(username:, password:, repeated_password:, email:)
				db = Models.connect_to_db
				return false if usernameExists(db:db, username:username) or password != repeated_password

				salt = SecureRandom.hex(3)
				password << salt
				password_hash = Digest::MD5.hexdigest(password)
				users = db['users']
				new_user = {username: username,
											password: password_hash,
											salt: salt, 
											repeated_password: repeated_password, 
											email: email}
				users.insert(new_user);
	  	end

	  	def login(username:, password:)
	    	db = Models.connect_to_db
	    	users = db['users']
	    	user = users.find_one({username:username})
	  		return false if !user

	    	password_hash = Digest::MD5.hexdigest(password + user['salt'])
	    	if password_hash == user['password'] then user["_id"] else false end
    	end

    end
  end
end