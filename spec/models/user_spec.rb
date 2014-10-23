require 'rails_helper'

RSpec.describe User, type: :model do

  before do 
    @user = User.new(name: "Some name", id: 12345) 
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:id) }


end