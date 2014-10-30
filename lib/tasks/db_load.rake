namespace :p2d do
	desc "Gets data from pipedrive API and stores them in the Database"

	require 'task_helper'
	include TaskHelper

	task populate_users: :environment do
		populate_users
	end

	task populate_deals: :environment do
		populate_deals
	end

	task populate_activities: :environment do
		populate_activities
	end

	task populate: [:populate_users, :populate_deals, :populate_activities]

end
