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

	def fake_populate_users
		response_in_json_format = '{"success":true,"data":[{"id":361107,"name":"Alan"},{"id":361103,"name":"Pooja Bangar"}],"additional_data":{"company_id":248912}}'
		response_in_hash_format = JSON.parse (response_in_json_format)
		TaskHelper.load_users(response_in_hash_format)
	end

	def fake_populate_deals
		response_in_json_format='{"deprecation_warning":{"#":"The following properties of deals have been or will be deprecated and will no longer be available starting at given times:","deprecated_fields":{"additional_data.dropbox_email":"2015-01-01 00:00:00"}},"success":true,"data":[{"id":1,"user_id":{"id":361103,"value":361103,"name":"Pooja Bangar","email":"pooja.d.bangar@gmail.com","has_pic":false},"title":"Test Deal","value":10000,"currency":"EUR","status":"won","won_time":"2014-10-16 09:24:55","add_time":"2014-10-16 09:10:28","update_time":"2014-10-16 09:24:55"},{"id":2,"user_id":{"id":361103,"value":361103,"name":"Pooja Bangar","email":"pooja.d.bangar@gmail.com","has_pic":false},"title":"Test 2 deal","value":20000,"currency":"EUR","status":"won","won_time":"2014-10-16 09:27:46","add_time":"2014-10-16 09:25:44","update_time":"2014-10-16 09:27:46"},{"id":3,"user_id":{"id":361107,"value":361107,"name":"Alan","email":"alan.noel.venegas@gmail.com","has_pic":false},"title":"1 deal","value":3000,"currency":"EUR","status":"open","won_time":null,"add_time":"2014-10-16 09:35:16","update_time":"2014-10-16 12:44:41"},{"id":4,"user_id":{"id":361107,"value":361107,"name":"Alan","email":"alan.noel.venegas@gmail.com","has_pic":false},"title":"1 deal (copy)","value":3000,"currency":"EUR","status":"won","won_time":"2014-10-16 09:35:57","add_time":"2014-10-16 09:35:20","update_time":"2014-10-16 09:35:57"},{"id":5,"user_id":{"id":361107,"value":361107,"name":"Alan","email":"alan.noel.venegas@gmail.com","has_pic":false},"title":"1 deal (copy) (copy)","value":3000,"currency":"EUR","status":"lost","won_time":null,"add_time":"2014-10-16 09:35:24","update_time":"2014-10-16 09:35:44"},{"id":6,"user_id":{"id":361107,"value":361107,"name":"Alan","email":"alan.noel.venegas@gmail.com","has_pic":false},"title":"1 deal (copy) (copy) (copy)","value":3000,"currency":"EUR","status":"open","won_time":null,"add_time":"2014-10-16 09:35:28","update_time":"2014-10-16 12:44:16"},{"id":7,"user_id":{"id":361103,"value":361103,"name":"Pooja Bangar","email":"pooja.d.bangar@gmail.com","has_pic":false},"title":"Test","value":10,"currency":"EUR","status":"open","won_time":null,"add_time":"2014-10-16 12:14:30","update_time":"2014-10-16 12:14:30"},{"id":8,"user_id":{"id":361107,"value":361107,"name":"Alan","email":"alan.noel.venegas@gmail.com","has_pic":false},"title":"Test #1.1","value":10,"currency":"USD","status":"won","won_time":"2014-10-23 08:21:02","add_time":"2014-10-23 08:20:46","update_time":"2014-10-23 08:26:45"},{"id":9,"user_id":{"id":361107,"value":361107,"name":"Alan","email":"alan.noel.venegas@gmail.com","has_pic":false},"title":"Test #1.2","value":0,"currency":"EUR","status":"open","won_time":null,"add_time":"2014-10-23 08:20:57","update_time":"2014-10-23 11:50:34"}],"additional_data":{"pagination":{"start":0,"limit":100,"more_items_in_collection":false}}}'
		response_in_hash_format = JSON.parse (response_in_json_format)
		TaskHelper.load_deals(response_in_hash_format)
	end

	module_function

end
