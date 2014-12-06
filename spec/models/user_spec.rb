require 'rails_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

RSpec.describe User, type: :model do

  before do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  describe 'basics' do

    it { should respond_to(:name) }
    it { should respond_to(:id) }
    it { should respond_to(:deals) }
    it { should respond_to(:activities) }

  end

  describe '.number_of_activities' do
    before do
      activity1 = FactoryGirl.create(:activity, user_id: @user.id)
    end

    it 'counts the activity' do
      expect(@user.number_of_activities).to be == 1
    end


    describe 'when adding an activity without a note' do
      before do
        activity2 = FactoryGirl.create(:activity, user_id: @user.id)
        activity2.note = ''
        activity2.save
      end

      it 'only counts the activities with a note' do
        expect(@user.number_of_activities).to be == 1
      end
    end
  end


  describe 'when loading from API' do
    before do
      VCR.use_cassette('pipedrive_users', allow_playback_repeats: true) do
        User.load_from_api
      end
    end
    it "includes the users" do
      expect(User.count).to be == 3
    end
  end
end
