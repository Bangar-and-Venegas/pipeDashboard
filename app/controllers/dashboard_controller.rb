class DashboardController < ApplicationController

	def index
		@users = User.all
		@revenue_per_sales_person = {}
		@users.each do |user|
			@revenue_per_sales_person[user.name]=Deal.where(user_id: user).sum(:value)
		end
	end
end
