class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :encrypted_password, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_day, presence: true
  validates :email, uniqueness: { case_sensitive: true }
end
