# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  asin            :string
#  title           :string
#  description     :string
#  detail_page_url :string
#  small_image     :string
#  medium_image    :string
#  large_image     :string
#  raw_info        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Item < ActiveRecord::Base
  serialize :raw_info , Hash

  has_many :ownerships, foreign_key: "item_id", dependent: :destroy
  has_many :users, through: :ownerships
  
  has_many :wants, class_name: "Want", foreign_key: "item_id", dependent: :destroy
  has_many :want_users, through: :wants, source: :user
  
  has_many :haves, class_name: "Have", foreign_key: "item_id", dependent: :destroy
  has_many :have_users, through: :haves, source: :user

end
