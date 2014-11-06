namespace :p2d do
	desc "Gets data from pipedrive API and stores them in the Database"

	task users: :environment do
		User.load_from_api
	end

	task deals: :environment do
		Deal.load_from_api
	end
	
	task activities: :environment do
		Activity.load_activities_from_api
	end
	
	task populate: [:users, :deals, :activities]

end