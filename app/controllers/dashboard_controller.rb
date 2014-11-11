class DashboardController < ApplicationController

	def index
		@users = User.all

		@revenue_per_person = {}
		@activities_per_person = {}
		@number_of_sales_per_person = {}
		@activities_per_person_per_day = {}
		@average_revenue_per_person = {}
		@call_conversion_rate_per_person = {}

		@users.each do |user|
			sales_value = {}
			sales_value[:total]=user.value_of_deals
			sales_value[:month]=user.value_of_deals(1.month.ago)
			sales_value[:quarter]=user.value_of_deals(3.month.ago)
			sales_value[:year]=user.value_of_deals(1.year.ago)
			@revenue_per_person[user.name]=sales_value

			sales_number = {}
			sales_number[:total]=user.number_of_deals
			sales_number[:month]=user.number_of_deals(1.month.ago)
			sales_number[:quarter]=user.number_of_deals(3.month.ago)
			sales_number[:year]=user.number_of_deals(1.year.ago)
			@number_of_sales_per_person[user.name]=sales_number

			average_revenue = {}
			average_revenue[:total]=user.average_revenue
			average_revenue[:month]=user.average_revenue(1.month.ago)
			average_revenue[:quarter]=user.average_revenue(3.month.ago)
			average_revenue[:year]=user.average_revenue(1.year.ago)
			@average_revenue_per_person[user.name]=average_revenue


			activities = {}
			activities[:total]=user.number_of_activities
			activities[:month]=user.number_of_activities(1.month.ago)
			activities[:quarter]=user.number_of_activities(3.month.ago)
			activities[:year]=user.number_of_activities(1.year.ago)
			@activities_per_person[user.name]=activities

			activities_per_day = {}
			activities_per_day[:month]=user.activities_per_day(1.month.ago)
			activities_per_day[:quarter]=user.activities_per_day(3.month.ago)
			activities_per_day[:year]=user.activities_per_day(1.year.ago)
			@activities_per_person_per_day[user.name]=activities_per_day

			call_conversion = {}
			call_conversion[:total]=user.call_conversion_rate
			call_conversion[:month]=user.call_conversion_rate(1.month.ago)
			call_conversion[:quarter]=user.call_conversion_rate(3.month.ago)
			call_conversion[:year]=user.call_conversion_rate(1.year.ago)
			@call_conversion_rate_per_person[user.name] = call_conversion

		end
	end
end
