require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    assign(:listings, [
      Listing.create!(),
      Listing.create!()
    ])
  end

  it "renders a list of listings" do
    render
  end
end
