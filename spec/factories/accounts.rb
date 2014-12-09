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

FactoryGirl.define do
  factory :account do
    account_number 1234
    owner_name "David"
  end
end
