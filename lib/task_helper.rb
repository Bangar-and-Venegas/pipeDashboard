module TaskHelper

	require 'rest_client'
	require 'json'

	def populate_users
		response_in_hash_format = get_hash_from_api("users", ":(id,name,created,modified)", "")
		load_users(response_in_hash_format)
	end

	def populate_deals
		response_in_hash_format = get_hash_from_api("deals",
																								":(id,user_id,title,value,currency,status,won_time,add_time,update_time)", "")
		load_deals(response_in_hash_format)
	end

	def populate_activities
		response_in_hash_format = get_hash_from_api("activities",
																								":(id,add_time,update_time,user_id,deal_id,type,done,note,due_time)",
																								"user_id=361107&start=0&")
		load_activities(response_in_hash_format)
	end

	def get_hash_from_api (model, filter, params)
		api_base_url = "https://api.pipedrive.com/v1/"
		api_token = Rails.application.secrets.pipedrive_api_key
		api_url = "#{api_base_url}#{model}#{filter}?#{params}api_token=#{api_token}"
		puts api_url
		response_in_json_format =RestClient.get(api_url)
		JSON.parse(response_in_json_format)
	end

	def load_users (response_in_hash_format)
		User.delete_all
		unformatted_users= response_in_hash_format["data"]
		unformatted_users.each do |user|
			User.create(name: user['name'], id: user['id'], created: user['created'], modified: user['modified'])
		end
	end

	def load_deals (response_in_hash_format)
		Deal.delete_all
		unformatted_deals = response_in_hash_format["data"]
		unformatted_deals.each do |deal|
			Deal.create(id: deal['id'],user_id: deal['user_id']['id'], title: deal['title'], value: deal['value'],
									currency: deal['currency'], status: deal['status'], won_time: deal['won_time'],
									add_time: deal['add_time'], update_time: deal['update_time'])
		end
	end

	def load_activities (response_in_hash_format)
		Activity.delete_all
		unformatted_activities = response_in_hash_format["data"]
		unformatted_activities.each do |activity|
			Activity.create(id: activity['id'], add_time: activity['add_time'], update_time: activity['update_time'],
											user_id: activity['user_id'], deal_id: activity['deal_id'], activity_type: activity['type'],
											done: activity['done'],	note: activity['note'], due_time: activity['due_time'])
		end
	end

	module_function

end
