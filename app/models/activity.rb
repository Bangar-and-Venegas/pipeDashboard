class Activity < ActiveRecord::Base
	extend PipedriveApiHandler
	belongs_to :user
	belongs_to :deal
end
