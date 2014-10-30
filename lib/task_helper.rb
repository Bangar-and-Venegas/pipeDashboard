module TaskHelper

	require 'rest_client'
	require 'json'

	def populate_users
		table = "users"
		filters = ":(id,name,created,modified)"
		params = ""
		hash_response = get_hash_from_api(table, filters, params)
		load_users(hash_response)
	end

	def populate_deals
		table = "deals"
		filters = ":(id,user_id,title,value,currency,status,won_time,add_time,update_time)"
		params = "filter_id=2&" # Only won deals
		hash_response = get_hash_from_api(table, filters, params)
		load_deals(hash_response)
	end

	def populate_activities
		Activity.delete_all
		table = "activities"
		filters = ":(id,add_time,update_time,user_id,deal_id,type,done,note,due_time)"
		User.all.each do |user|
			params = "user_id=#{user.id}&done=1&" # Only done activities
			hash_response = get_hash_from_api(table, filters, params)
			load_activities(hash_response)
		end
	end

	def get_hash_from_api (model, filter, params)
		api_base_url = "https://api.pipedrive.com/v1/"
		api_token = Rails.application.secrets.pipedrive_api_key
		api_url = "#{api_base_url}#{model}#{filter}?#{params}api_token=#{api_token}"
		response_in_json_format =RestClient.get(api_url)
		JSON.parse(response_in_json_format)
	end

	def load_users (hash_response)
		User.delete_all
		unformatted_users= hash_response["data"]
		unformatted_users.each do |user|
			User.create(user)
		end
	end

	def load_deals (hash_response)
		Deal.delete_all
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
