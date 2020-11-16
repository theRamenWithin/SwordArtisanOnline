require 'pg'
require 'faker'

User.destroy_all
Order.destroy_all
Listing.destroy_all

condition = ['New', 'Like-New', 'Used']
category1 = ['Practice', 'Blank', 'Replica']
category2 = ['Cutting', 'Thrusting', 'Blunt']

# Create standard user with one listing and one order
10.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.email = Faker::Internet.email
    user.date_of_birth = Faker::Date.between(from: '1930-01-01', to: '2020-01-01')
    user.password = "password"
    user.password_confirmation = "password"
    user.username = Faker::String.name
    user.save

    1.times do
        listing = Listing.new
        listing.title = Faker::Games::DnD.melee_weapon
        listing.description = Faker::Lorem.paragraph_by_chars(number: 240, supplemental: false)
        listing.condition = condition[rand(0..2)]
        listing.category = [category1[rand(0..2)], category2[rand(0..2)]]
        listing.price = Faker::Number.decimal(l_digits: 3, r_digits: 2)
        listing.user_id = user.id
        # downloaded_image = URI.open("#{Faker::LoremFlickr.colorized_image(size: "500x600", search_terms: ['sword'])}")
        # listing.picture.attach(io: downloaded_image, filename: "#{Faker::Number.within(range: 1..999999)}.jpg")
        listing.save
    end 

    1.times do
        order = Order.new
        order.title = Faker::Games::DnD.melee_weapon
        order.description = Faker::Lorem.paragraph_by_chars(number: 240, supplemental: false)
        order.condition = condition[rand(0..2)]
        order.category = [category1[rand(0..2)], category2[rand(0..2)]]
        order.price = Faker::Number.decimal(l_digits: 3, r_digits: 2) #=> 11.88
        order.user_id = user.id
        order.seller_id = Faker::Number.within(range: 1..10)
        # downloaded_image = URI.open("#{Faker::LoremFlickr.colorized_image(size: "500x600", search_terms: ['sword'])}")
        # order.picture.attach(io: downloaded_image, filename: "#{Faker::Number.within(range: 1..999999)}.jpg")
        order.save
    end

    1.times do
        address = Address.new
        address.street = Faker::Address.street_address
        address.city = Faker::Address.city
        address.state_or_province = Faker::Address.community
        address.postal_code = Faker::Address.postcode
        address.country = Faker::Address.country
        address.phone = Faker::PhoneNumber.cell_phone_in_e164
        address.title = "Home"
        address.users_id = user.id
    end
end 

# Create an admin user
1.times do
    user = User.new
    user.first_name = "admin"
    user.last_name = "admin"
    user.email = "admin@swordartisanonline.com"
    user.date_of_birth = Faker::Date.between(from: '1930-01-01', to: '2020-01-01')
    user.password = "password"
    user.password_confirmation = "password"
    user.username = "admin"
    user.toggle!(:admin?)
    user.save
end