class Address < ApplicationRecord
    belongs_to :user

    validates :street, 
                :city,
                :state_or_province,
                :postal_code,
                :country,
                :phone,
                :title,
                :users_id,
                length: { in: 3..50 },presence: true
end
