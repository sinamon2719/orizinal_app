class UserOrder

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :user_item_id, :token, :item_id


  with_options presence: true do
    validates :post_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
    validates :user_id
    validates :item_id
    validates :token
  end

#ユーザーモデル
  with_options presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '半角英数字を使用してください' } do
    validates :password
  end
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角文字を使用してください' } do
    validates :first_name
    validates :family_name
  end

  with_options presence: true, format: {with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: '全角カタカナのみで入力して下さい'} do
    validates :first_name_kana
    validates :family_name_kana
  end


  #アイテムモデル
  validates_inclusion_of :price, in: 300..9_999_999
  with_options presence: true, format: { with: /\A[0-9]+\Z/, message: '半角数字を使用してください' } do
    validates :price
  end
end


#オーダーモデル
validates :prefecture_id, numericality: { other_than: 1 }
  validates :phone_number, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10_000_000_000, message: '桁数が違います' }
  with_options presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを含んでください'} do
    validates :post_code
  end
  with_options presence: true, format: {with: /\A\d{11}\z/, message: 'の番号が違います'} do
    validates :phone_number
  end


  def save
    user_item = UserItem.create(user_id: user_id, item_id: item_id)
    Order.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, user_item_id: user_item.id)
  end
end