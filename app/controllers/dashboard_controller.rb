class DashboardController < ApplicationController

	def index
		@users = User.all

		@revenue_per_person = {}
		@activities_per_person = {}
		@number_of_sales_per_person = {}
		@activities_per_person_per_day = {}
		@average_revenue_per_person = {}

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

			average_revenue = {}
			average_revenue[:total]=sales_value[:total]/sales_number[:total]
			average_revenue[:month]=sales_value[:month]/sales_number[:total]
			average_revenue[:quarter]=sales_value[:quarter]/sales_number[:quarter]
			average_revenue[:year]=sales_value[:year]/sales_number[:year]
			@average_revenue_per_person[user.name]=average_revenue


			activities = {}
			activities_per_day = {}
			activities[:total]=Activity.where(user_id: user).count
			activities[:month]=Activity.where(user_id: user, marked_as_done_time: 1.month.ago..Time.now).count
			activities_per_day[:month]=activities[:month]/30.0
			activities[:quarter]=Activity.where(user_id: user, marked_as_done_time: 3.month.ago..Time.now).count
			activities_per_day[:quarter]=activities[:quarter]/(Time.now - 1.month.ago)
			activities[:year]=Activity.where(user_id: user, marked_as_done_time: 1.year.ago..Time.now).count
			activities_per_day[:year]=activities[:year]/(Time.now - 1.year.ago)
			@activities_per_person[user.name]=activities
			@activities_per_person_per_day[user.name]=activities_per_day
		end
	end
end