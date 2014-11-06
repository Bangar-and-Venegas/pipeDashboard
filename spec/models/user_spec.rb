require 'rails_helper'

VCR.configure do |c|
	c.cassette_library_dir = 'fixtures/vcr_cassettes'
	c.hook_into :fakeweb
end

RSpec.describe User, type: :model do

	before do
		@user = User.create(name: "Some name", id: 12345)
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:id) }

	describe 'when loading from API' do
		before do
			VCR.use_cassette('pipedrive_users', allow_playback_repeats: true) do
				User.load_from_api
			end
		end
		it "includes the users" do
			expect(User.count).to be == 2
		end
	end
end
