module DatabaseLoader

	def parse (my_hash)

		puts my_hash
		unformatted_users= my_hash["data"]

		User.delete_all
		
		unformatted_users.each do |user|
			User.create(name: user['name'], id: user['id'])
		end
	end

	module_function

end
