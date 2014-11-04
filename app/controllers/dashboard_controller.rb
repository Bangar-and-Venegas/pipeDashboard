class DashboardController < ApplicationController

	def index
		@users = User.all

		@revenue_per_person = {}
		@activities_per_person = {}
		@number_of_sales_per_person = {}

		@users.each do |user|
			sales_value = {}
			sales_value[:total]=Deal.where(user_id: user).sum(:value)
			sales_value[:month]=Deal.where(user_id: user, won_time: 1.month.ago..Time.now).sum(:value)
			sales_value[:quarter]=Deal.where(user_id: user, won_time: 3.month.ago..Time.now).sum(:value)
			sales_value[:year]=Deal.where(user_id: user, won_time: 1.year.ago..Time.now).sum(:value)
			@revenue_per_person[user.name]=sales_value

			sales_number = {}
			sales_number[:total]=Deal.where(user_id: user).count
			sales_number[:month]=Deal.where(user_id: user, won_time: 1.month.ago..Time.now).count
			sales_number[:quarter]=Deal.where(user_id: user, won_time: 3.month.ago..Time.now).count
			sales_number[:year]=Deal.where(user_id: user, won_time: 1.year.ago..Time.now).count
			@number_of_sales_per_person[user.name]=sales_number

			activities = {}
			activities[:total]=Activity.where(user_id: user).count
			activities[:month]=Activity.where(user_id: user, marked_as_done_time: 1.month.ago..Time.now).count
			activities[:year]=Activity.where(user_id: user, marked_as_done_time: 1.year.ago..Time.now).count
			@activities_per_person[user.name]=activities
		end
	end
end
