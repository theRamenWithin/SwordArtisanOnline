class JoinOrdersListings < ActiveRecord::Migration[6.0]
  def change
    create_join_table :orders, :listings
  end
end
