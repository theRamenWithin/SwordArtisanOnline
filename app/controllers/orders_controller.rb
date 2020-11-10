class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def show
        session = Stripe::CheckoutSession.create(
            payment_method_types: '[card]',
            customer_email: current_user.email,
            line_items: [(
                name: @listing.title,
                description: @listing.description,
                image: @listing.picture,
                amount: (@listing.price * 100).to_i,
                currency: 'AUD',
                quantity: 1
            )],
            payment_intent_data: {
                metadata: {
                    listing_id: @listing.id
                }
            },
            success_url: "#{root_url}payments/success?listingId=#{@listing.id}",
            cancel_url: "#{root_url}events"
        )
        @session_id = @session.id
    end

    def success
        
    end
end
