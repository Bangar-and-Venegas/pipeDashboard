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
end
