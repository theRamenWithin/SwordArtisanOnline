class ListingsController < ApplicationController
  # Initializes CanCanCan functionality for authorization
  load_and_authorize_resource
  # Set what @listing is before these functions
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # Accept these parameters for create
  before_action :listing_params, only: [:create]
  # Use Devise to require that a user be logged in except for these functions.
  before_action :authenticate_user!, except: [:index, :show]

  # The index page contains all listing. 
  # If something has been entered into the search field, return listings that match the SQL LIKE query and then flash an alert.
  def index
    @listings = Listing.all
    @search = params["search"]
    if @search.present?
      @name = @search["name"]
      @listings = Listing.where("title ILIKE ?", "%#{@name}%")
      flash.alert = "Showing results for ... '#{@search[:name]}' "
    end
  end

  # For showing individual listings.
  # If the user is signed in, create a token for stripe to allow a purchase.
  def show
    @listings = Listing.where(id: params[:ids])

    if user_signed_in?
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
  end

  # Creates a template for a new listing
  def new
    @listing = Listing.new
  end

  def edit
  end

  # Create a listing accepting the listing parameters only.
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

  # Updates a listing accepting the listing parameters.
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

  # Destroys a listing
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
