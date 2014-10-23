module DBLoadHelper

	def parse (my_hash)

		puts my_hash
		unformatted_users= my_hash["data"]

		unformatted_users.each do |user|
			User.create(name: user['name'], identifier: user['id'])
		end
	end
	
end