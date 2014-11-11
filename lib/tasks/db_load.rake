namespace :p2d do
	desc "Gets data from pipedrive API and stores them in the Database"

	task users: :environment do
		User.repopulate
	end

	task deals: :environment do
		Deal.repopulate
	end
	
	task activities: :environment do
		Activity.repopulate
	end
	
	task populate: [:users, :deals, :activities]

end