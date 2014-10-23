require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe 'GET #index' do
    it 'returns a list of restaurants' do
      get :index
      expect(response).to be_success
      expect(assigns(:users)).to eq(User.all)
    end
  end
  
end