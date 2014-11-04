require 'rails_helper'

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

end
