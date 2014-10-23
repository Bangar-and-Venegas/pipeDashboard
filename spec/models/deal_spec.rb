require 'rails_helper'

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

end