class Deal < ActiveRecord::Base
	extend PipedriveApiHandler
	belongs_to :user
	has_many :activities

	def self.repopulate
		self.delete_all
		load_from_api
	end

	def self.arrange_params_for_api(start=0, user_id=0)
		input = {}
		input[:table]="deals"
		input[:filters]=":(id,user_id,title,value,currency,status,won_time,add_time,update_time)"
		input[:params]="filter_id=2&start=#{start}&" # Only won deals
		input
	end
end
