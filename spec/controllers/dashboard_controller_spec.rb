require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

	describe 'GET #index' do
		before do
			get :index
		end

		it 'gives a successful response' do
			expect(response).to be_success
		end

		it 'creates a list of users' do
			expect(assigns(:users)).to eq(User.all)
		end

		it 'creates a hash with revenue per user' do
			expect(assigns(:revenue_per_sales_person)).not_to be_nil
		end
		
	end
end
