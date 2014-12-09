# == Schema Information
#
# Table name: trees
#
#  id         :integer          not null, primary key
#  name       :string
#  leaf_count :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :tree do
    name "Oak Tree"
    leaf_count 500
  end
end
