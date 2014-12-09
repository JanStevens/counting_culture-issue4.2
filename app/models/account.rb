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

class Account < ActiveRecord::Base
  has_and_belongs_to_many :users
end
