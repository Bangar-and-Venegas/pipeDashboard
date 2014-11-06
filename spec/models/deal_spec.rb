require 'rails_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

RSpec.describe Deal, type: :model do

  before do 
    @deal = Deal.new(title: "Some title", id: 12345) 
  end

  subject { @deal }

  it { should respond_to(:title) }
  it { should respond_to(:id) }
  it { should respond_to(:value) }
  it { should respond_to(:currency) }
  it { should respond_to(:status) }
  it { should respond_to(:won_time) }
  it { should respond_to(:user_id) }
  it { should respond_to(:add_time) }
  it { should respond_to(:update_time) }
  it { should respond_to(:user) }

  describe 'when loading from API' do
    before do
      VCR.use_cassette('pipedrive_deals', allow_playback_repeats: true) do
        Deal.load_from_api
      end
    end
    it "includes the users" do
      expect(Deal.count).to be == 5
    end
  end

end