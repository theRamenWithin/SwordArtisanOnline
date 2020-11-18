class Listing < ApplicationRecord
    belongs_to :user
    has_one_attached :picture

    validates :title, length: { in: 3..50 }, presence: true
    validates :description, length: { in: 10..250 }, presence: true
    validates :price, numericality: true
    validates :condition, :category, :user_id, presence: true
end
