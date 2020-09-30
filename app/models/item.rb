class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :prefecture

  validates :category_id, :shipping_cost_id, :shipping_day_id, :prefecture_id, numericality: { other_than: 1 }

  has_one :user_item
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :content
    validates :shipping_cost_id
    validates :shipping_day_id
    validates :prefecture_id
    validates :category_id
  end
end
