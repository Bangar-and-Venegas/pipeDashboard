namespace :pipedrive2db do
	desc "TODO"

	task test1: :environment do
		
		init_require

		api_base_url = "http://api.pipedrive.com/v1/"
		api_params= "users:(id,name)"
		api_token = Rails.application.secrets.pipedrive_api_key

		api_url = "#{api_base_url}#{api_params}?api_token=#{api_token}"
		my_raw_data =RestClient.get(api_url)

		parse (my_raw_data)
	end

	task faketest1: :environment do

		init_require
		my_raw_data = '{"success":true,"data":[{"id":361107,"name":"Alan"},{"id":361103,"name":"Pooja Bangar"}],"additional_data":{"company_id":248912}}'

		parse (my_raw_data)
	end

	def parse (my_raw_data)
		my_hash = JSON.parse (my_raw_data)

		puts my_hash
		unformatted_users= my_hash["data"]

		unformatted_users.each do |user|
			User.create(name: user['name'], identifier: user['id'])
		end
	end

	def init_require
		require 'rest_client'
		require 'json'
	end

end
