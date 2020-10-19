class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one :user_item
  belongs_to :user
  has_one_attached :image
  has_one_attached :video

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  with_options presence: true do
    validates :name
    validates :content
    validates :shipping_cost_id
    validates :shipping_day_id
    validates :prefecture_id
    validates :category_id
    validates :image
    validates :quantity
  end

  validates_inclusion_of :price, in: 300..9_999_999
  with_options presence: true, format: { with: /\A[0-9]+\Z/ } do
    validates :price
  end

  
  belongs_to_active_hash :category
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :prefecture

  validate :image_presence
  validates :youtube_url, format: { with: /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/ , message: 'を入力してください'},allow_blank: true
  validates :category_id, :shipping_cost_id, :shipping_day_id, :prefecture_id, numericality: { other_than: 1 }
  validate :required_either_email_or_phone
  


  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end

  private

  def required_either_email_or_phone

    return if youtube_url.present? ^ video.present?

    errors.add(:base, 'YOUTUBE,URLまたは動画のどちらか一方を入力してください')
  end
end
