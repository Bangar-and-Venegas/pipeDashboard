class User < ActiveRecord::Base
	extend PipedriveApiHandler
	has_many :deals
	has_many :activities

	def self.repopulate
		self.delete_all
		load_from_api
	end

	def self.arrange_params_for_api(start=0,user_id=0)
		input = {}
		input[:table]="users"
		input[:filters]=":(id,name,created,modified)"
		input[:params]=""
		input
	end

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
		if number_of_deals(since, up_to) == 0
			return 0.0
		end
		value_of_deals(since, up_to) / number_of_deals(since, up_to)
	end

	def activities_per_day(since = '01/01/1990', up_to = Time.now)
		number_of_activities(since, up_to)*86400/(up_to - since )
	end

	def call_conversion_rate(since = '01/01/1990', up_to = Time.now)
		puts "Number of deals: #{number_of_deals(since, up_to)}"
		if number_of_deals(since, up_to) == 0
			return 0.0
		end
		calls_in_won_deal = 0
		self.deals.where(won_time: since..up_to).each do |deal|
			calls_in_won_deal = calls_in_won_deal + deal.activities.count
		end
		puts "Calls in won deals: #{calls_in_won_deal}"
		calls_in_won_deal.to_f / number_of_deals(since, up_to)
	end
end
