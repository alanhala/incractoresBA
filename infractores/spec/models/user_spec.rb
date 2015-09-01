require 'rails_helper'

describe "#create_or_update_name" do
  before do
    @user1 = double("Twitter::User")
    allow(@user1).to receive(:id).and_return(1)
    allow(@user1).to receive(:screen_name).and_return("pepe")

  end

  it "should create an user if it doesn't exist" do
    user = User.create_or_update_name(@user1)
    expect(User.count).to eq(1)
    expect(user.account_name).to eq("pepe")
    expect(user.account_id).to eq("1")
  end

  it "should update the account_name if the user exists but changed his user_name" do
    User.create_or_update_name(@user1)
    allow(@user1).to receive(:screen_name).and_return("juan")
    user = User.create_or_update_name(@user1)
    expect(User.count).to eq(1)
    expect(user.account_name).to eq("juan")
  end
end
