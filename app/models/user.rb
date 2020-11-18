class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = "#{auth.info.nickname}@twitter.org"
    user.password = Devise.friendly_token[0, 20]
    user.first_name = auth.info.name.split[0]
    user.last_name = auth.info.name.split[1..].join(' ')
    user.username = auth.info.nickname
    end
  end

  def email_required?
    false
  end

  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :listings

  validates :username, length: { in: 3..20 }, presence: true, uniqueness: true
  validates :first_name, length: { maximum: 50 }, presence: true
  validates :last_name, length: { maximum: 50 }, presence: true
  validates :email, presence: true, uniqueness: true
  validates :date_of_birth, presence: true
  
end
