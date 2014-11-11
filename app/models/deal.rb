class Deal < ActiveRecord::Base
	extend PipedriveApiHandler
	belongs_to :user
	has_many :activities

	def self.repopulate
		self.delete_all
		load_from_api
	end
	
end
