require 'rails_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

RSpec.describe Activity, type: :model do

  before do 
    @activity = Activity.new(id: 12345) 
  end

  subject { @activity }

  it { should respond_to(:id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:deal_id) }
  it { should respond_to(:activity_type) }
  it { should respond_to(:done) }
  it { should respond_to(:note) }
  it { should respond_to(:marked_as_done_time) }

  describe 'when loading from API' do
    before do
      VCR.use_cassette('pipedrive_activities', allow_playback_repeats: true) do
        User.load_from_api
        Activity.load_activities_from_api
      end
    end
    it "includes the activities" do
      expect(Activity.count).to be == 10
    end
  end

end
