class Item < ApplicationRecord
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
    validates :judgment_id
  end
end
