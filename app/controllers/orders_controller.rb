class OrdersController < ApplicationController
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
