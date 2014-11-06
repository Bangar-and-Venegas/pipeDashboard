class User < ActiveRecord::Base
	extend PipedriveApiHandler
	has_many :deals
	has_many :activities

	def value_of_deals(since = '01/01/1990', up_to = Time.now)
		self.deals.where(won_time: since..up_to).sum(:value)
	end

	def number_of_deals(since = '01/01/1990', up_to = Time.now)
		self.deals.where(won_time: since..up_to).count
	end

	def number_of_activities(since = '01/01/1990', up_to = Time.now)
		self.activities.where(marked_as_done_time: since..up_to).count
	end

	def average_revenue(since = '01/01/1990', up_to = Time.now)
		value_of_deals(since, up_to) / number_of_deals(since, up_to)
	end

	def activities_per_day(since = '01/01/1990', up_to = Time.now)
		number_of_activities(since, up_to)*86400/(up_to - since )
	end
end
