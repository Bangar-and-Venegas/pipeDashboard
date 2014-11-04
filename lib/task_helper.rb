module TaskHelper

	require 'rest_client'
	require 'json'

	def populate_users
		User.delete_all
		table = "users"
		filters = ":(id,name,created,modified)"
		params = ""
		hash_response = get_hash_from_api(table, filters, params)
		load_users(hash_response)
	end

	def populate_deals
		Deal.delete_all
		table = "deals"
		filters = ":(id,user_id,title,value,currency,status,won_time,add_time,update_time)"
		start = 0
		more_items_in_collection=true
		while more_items_in_collection
			params = "filter_id=2&start=#{start}&" # Only won deals
			hash_response = get_hash_from_api(table, filters, params)
			load_deals(hash_response)
			start = hash_response["additional_data"]["pagination"]["next_start"]
			more_items_in_collection = hash_response["additional_data"]["pagination"]["more_items_in_collection"]
		end
	end

	def populate_activities
		Activity.delete_all
		table = "activities"
		filters = ":(id,add_time,update_time,user_id,deal_id,type,done,note,marked_as_done_time)"
		User.all.each do |user|
			start = 0
			more_items_in_collection=true
			while more_items_in_collection
				params = "user_id=#{user.id}&done=1&start=#{start}&" # Only done activities
				hash_response = get_hash_from_api(table, filters, params)
				load_activities(hash_response)
				start = hash_response["additional_data"]["pagination"]["next_start"]
				more_items_in_collection = hash_response["additional_data"]["pagination"]["more_items_in_collection"]
			end
		end
	end

	def get_hash_from_api (model, filter, params)
		api_base_url = "https://api.pipedrive.com/v1/"
		api_token = Rails.application.secrets.pipedrive_api_key
		api_url = "#{api_base_url}#{model}#{filter}?#{params}api_token=#{api_token}"
		puts api_url
		response_in_json_format =RestClient.get(api_url)
		JSON.parse(response_in_json_format)
	end

	def load_users (hash_response)
		unformatted_users= hash_response["data"]
		unformatted_users.each do |user|
			User.create(user)
		end
	end

	def load_deals (hash_response)
		unformatted_deals = hash_response["data"]
		unformatted_deals.each do |deal|
			deal[:user_id]=deal['user_id']['id']
			deal.delete('user_id')
			Deal.create(deal)
		end
	end

	def load_activities (hash_response)
		unformatted_activities = hash_response["data"]
		unformatted_activities.each do |activity|
			activity[:activity_type]= activity['type']
			activity.delete('type')
			Activity.create(activity)
		end
	end

	module_function

end
