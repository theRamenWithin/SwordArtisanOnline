class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.first_name = auth.info.name.split[0]
    user.last_name = auth.info.name.split[1..].join(' ')
    user.username = auth.info.nickname
    #user.image = auth.info.image # assuming the user model has an image
    # user.skip_confirmation!
    end
  end

  def email_required?
    false
  end

  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :listings
end
