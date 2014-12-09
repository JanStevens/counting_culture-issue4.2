# == Schema Information
#
# Table name: accounts
#
#  id             :integer          not null, primary key
#  account_number :integer
#  owner_name     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

describe Account do
  let(:user) { create :user }
  let(:account) { create :account, users: [user] }
  let(:tree) { create :tree }

  it "should pass" do
    expect(tree).to eq tree
  end

  it "should fail" do
    expect(account).to eq account
  end
end
