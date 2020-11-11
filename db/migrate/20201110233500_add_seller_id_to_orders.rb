class AddSellerIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :seller_id, :bigint, null: false
  end
end
