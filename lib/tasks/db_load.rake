require "#{Rails.root}/app/helpers/db_load_helper"
include DBLoadHelper


namespace :pipedrive2db do
	desc "TODO"

	require 'rest_client'
	require 'json'

	task test1: :environment do

		api_base_url = "http://api.pipedrive.com/v1/"
		api_params= "users:(id,name)"
		api_token = Rails.application.secrets.pipedrive_api_key

		api_url = "#{api_base_url}#{api_params}?api_token=#{api_token}"
		my_raw_data =RestClient.get(api_url)
		my_hash = JSON.parse (my_raw_data)

		parse (my_hash)
	end

	task faketest1: :environment do

		my_raw_data = '{"success":true,"data":[{"id":361107,"name":"Alan"},{"id":361103,"name":"Pooja Bangar"}],"additional_data":{"company_id":248912}}'
		my_hash = JSON.parse (my_raw_data)

		parse (my_hash)
	end


end
