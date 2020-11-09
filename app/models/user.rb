class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :address, dependent: :destroy, optional: true
  has_many :orders
  has_many :listings
end
