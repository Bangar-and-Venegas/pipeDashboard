module PipedriveApiHandler

	def load_from_api
		self.delete_all
		start = 0
		more_items_in_collection=true
		while more_items_in_collection
			input = arrange_params_for_api(start)
			hash_response = get_hash_from_api(input)
			load(hash_response)
			if self.name.eql?("User")
				more_items_in_collection = false
			else
				start = hash_response["additional_data"]["pagination"]["next_start"]
				more_items_in_collection = hash_response["additional_data"]["pagination"]["more_items_in_collection"]
			end
		end
	end

	def load_activities_from_api
		self.delete_all
		User.all.each do |user|
			start = 0
			more_items_in_collection=true
			while more_items_in_collection
				input = arrange_activity_params_for_api(start,user.id)
				hash_response = get_hash_from_api(input)
				load(hash_response)
				start = hash_response["additional_data"]["pagination"]["next_start"]
				more_items_in_collection = hash_response["additional_data"]["pagination"]["more_items_in_collection"]
			end
		end
	end

	def arrange_params_for_api(start)
		if self.name.eql?("User")
			arrange_user_params_for_api
		elsif self.name.eql?("Deal")
			arrange_deal_params_for_api(start)
		elsif self.name.eql?("Activity")
			arrange_activity_params_for_api(start)
		end
	end

	def arrange_user_params_for_api
		input = {}
		input[:table]="users"
		input[:filters]=":(id,name,created,modified)"
		input[:params]=""
		input
	end

	def arrange_deal_params_for_api(start)
		input = {}
		input[:table]="deals"
		input[:filters]=":(id,user_id,title,value,currency,status,won_time,add_time,update_time)"
		input[:params]="filter_id=2&start=#{start}&" # Only won deals
		input
	end

	def arrange_activity_params_for_api(start,user_id)
		input = {}
		input[:table]="activities"
		input[:filters]=":(id,add_time,update_time,user_id,deal_id,type,done,note,marked_as_done_time)"
		input[:params]="user_id=#{user_id}&done=1&start=#{start}&" # Only done activities
		input
	end


	def get_hash_from_api(input)
		api_base_url = "https://api.pipedrive.com/v1/"
		api_token = Rails.application.secrets.pipedrive_api_key
		api_url = "#{api_base_url}#{input[:table]}#{input[:filters]}?#{input[:params]}api_token=#{api_token}"
		response_in_json_format =RestClient.get(api_url)
		JSON.parse(response_in_json_format)
	end


	def load(hash_response)
		unformatted_users= hash_response["data"]
		unformatted_users.each do |element|
			format_results(element)
			self.create(element)
		end
	end

	def format_results(unformatted_result)
		if self.name.eql?("Deal")
			unformatted_result[:user_id]=unformatted_result['user_id']['id']
			unformatted_result.delete('user_id')
		elsif self.name.eql?("Activity")
			unformatted_result[:activity_type]= unformatted_result['type']
			unformatted_result.delete('type')
		end
	end
end
