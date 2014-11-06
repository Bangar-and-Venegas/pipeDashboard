class Deal < ActiveRecord::Base
	extend PipedriveApiHandler
	belongs_to :user
	has_many :activities
end
