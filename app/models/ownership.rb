# == Schema Information
#
# Table name: ownerships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_id    :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ownership < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :item, class_name: "Item"
end
