class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
          
  has_many :items
  has_many :comments, dependent: :destroy
  has_many :sns_credentials
  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item

  validates :nickname, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :email, uniqueness: { case_sensitive: true }

  with_options on: :create? do
    validates :password, presence: true,format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '半角英数字を使用してください' }
  end

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create

    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

end
