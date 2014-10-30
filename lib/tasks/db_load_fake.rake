namespace :fake_p2d do
	desc "Fakes data from pipedrive API and stores them in the Database"

	require 'task_helper'
	include TaskHelper

	task fake_populate_users: :environment do
		fake_populate_users
	end

	task fake_populate_deals: :environment do
		fake_populate_deals
	end

end
