class Activity < ActiveRecord::Base
	extend PipedriveApiHandler
	belongs_to :user
	belongs_to :deal

	def self.repopulate
		self.delete_all
		User.all.each do |user|
			load_from_api(user.id)
		end
	end

	def self.arrange_params_for_api(start=0,user_id=0)
		input = {}
		input[:table]="activities"
		input[:filters]=":(id,add_time,update_time,user_id,deal_id,type,done,note,marked_as_done_time)"
		input[:params]="user_id=#{user_id}&done=1&start=#{start}&" # Only done activities
		input
	end

end
