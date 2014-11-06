class Deal < ActiveRecord::Base
	extend PipedriveApiHandler
	belongs_to :user
end
