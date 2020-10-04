class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :encrypted_password, presence: true
  validates :email, uniqueness: { case_sensitive: true }

  with_options presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '半角英数字を使用してください' } do
    validates :password
  end
end
