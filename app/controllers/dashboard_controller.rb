class DashboardController < ApplicationController

	def index
		@users = User.all

		@revenue_per_sales_person = {}
		@activities_per_sales_person = {}


		@users.each do |user|
			sales = {}
			sales[:total]=Deal.where(user_id: user).sum(:value)
			sales[:month]=Deal.where(user_id: user, won_time: 1.month.ago..Time.now).sum(:value)
			sales[:quarter]=Deal.where(user_id: user, won_time: 3.month.ago..Time.now).sum(:value)
			sales[:year]=Deal.where(user_id: user, won_time: 1.year.ago..Time.now).sum(:value)
			@revenue_per_sales_person[user.name]=sales

			activities = {}
			activities[:total]=Activity.where(user_id: user).count
			activities[:month]=Activity.where(user_id: user, marked_as_done_time: 1.month.ago..Time.now).count
			@activities_per_sales_person[user.name]=activities
		end
	end
end
