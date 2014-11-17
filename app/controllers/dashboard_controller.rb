class DashboardController < ApplicationController

	def index
		@users = User.all

		@users_data = []

		colors = generate_colors

		@users.each do |user|

			sales_value = {}
			sales_value[:total]=user.value_of_deals
			sales_value[:month]=user.value_of_deals(1.month.ago)
			sales_value[:quarter]=user.value_of_deals(3.month.ago)
			sales_value[:year]=user.value_of_deals(1.year.ago)

			sales_number = {}
			sales_number[:total]=user.number_of_deals
			sales_number[:month]=user.number_of_deals(1.month.ago)
			sales_number[:quarter]=user.number_of_deals(3.month.ago)
			sales_number[:year]=user.number_of_deals(1.year.ago)

			average_revenue = {}
			average_revenue[:total]=user.average_revenue
			average_revenue[:month]=user.average_revenue(1.month.ago)
			average_revenue[:quarter]=user.average_revenue(3.month.ago)
			average_revenue[:year]=user.average_revenue(1.year.ago)

			activities = {}
			activities[:total]=user.number_of_activities
			activities[:month]=user.number_of_activities(1.month.ago)
			activities[:quarter]=user.number_of_activities(3.month.ago)
			activities[:year]=user.number_of_activities(1.year.ago)

			calls = {}
			calls[:total]=user.number_of_calls
			calls[:month]=user.number_of_calls(1.month.ago)
			calls[:quarter]=user.number_of_calls(3.month.ago)
			calls[:year]=user.number_of_calls(1.year.ago)

			calls_per_day = {}
			calls_per_day[:month]=user.calls_per_day(1.month.ago)
			calls_per_day[:quarter]=user.calls_per_day(3.month.ago)
			calls_per_day[:year]=user.calls_per_day(1.year.ago)

			call_conversion = {}
			call_conversion[:total]=user.call_conversion_rate
			call_conversion[:month]=user.call_conversion_rate(1.month.ago)
			call_conversion[:quarter]=user.call_conversion_rate(3.month.ago)
			call_conversion[:year]=user.call_conversion_rate(1.year.ago)

			user_data= {}
			user_data[:name]=user.name
			user_data[:revenue]=sales_value
			user_data[:number_of_sales]=sales_number
			user_data[:average_revenue]=average_revenue
			user_data[:activities]=activities
			user_data[:calls]=calls
			user_data[:calls_per_day]=calls_per_day
			user_data[:call_conversion_rate]=call_conversion
			user_data[:color]=colors.shift

			@users_data << user_data

		end
	end

	private

	def generate_colors
		colors=[]
		colors<<"#B21516"
		colors<<"#1531B2"
		colors<<"#1AB244"
		colors<<"#F2EB27"
		colors<<"#000000"
		colors<<"#159159"
		colors<<"#753753"
		colors<<"#886644"
		colors<<"#AAAAAA"

		colors
	end
end
