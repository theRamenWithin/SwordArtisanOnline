class OrdersController < ApplicationController
    # Creates a new listing after stripe is success and redirects to the success page
    before_action :new, only: [:success]
    before_action :set_listing, only: [:success]

    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def new
        @order = Order.new
    end

    def show
    end

    # Creates an order based on the listing passed to it and then saves it.
    # Doing it this way so that if the listing is deleted, the order is preserved.
    def success
        @order.user_id = current_user.id
        @order.seller_id = @listing.user_id
        @order.title = @listing.title
        @order.description = @listing.description
        @order.condition = @listing.condition
        @order.category = @listing.category
        @order.price = @listing.price
        @order.save
    end

    private

    def set_listing
      @listing = Listing.find(params[:listingId])
    end

end
