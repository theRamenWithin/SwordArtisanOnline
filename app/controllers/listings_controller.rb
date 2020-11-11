class ListingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :listing_params, only: [:create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.all
  end

  def show
    @listings = Listing.where(id: params[:ids])

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
          name: @listing.title,
          description: "#{@listing.description[0..20]}...",
          images: [@listing.picture],
          amount: (@listing.price * 100).to_i,
          currency: 'aud',
          quantity: 1,
      }],
      payment_intent_data: {
          metadata: {
              listing_id: @listing.id
          }
      },
      success_url: "#{orders_success_url}?listingId=#{@listing.id}",
      cancel_url: "#{root_url}"
    )
    @session_id = session.id
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def create
    @listing = current_user.listings.create(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :condition, {:category => []}, :price, :picture)
    end
end
