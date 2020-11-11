class AddDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    drop_join_table :orders, :listings
    add_column :orders, :title, :string, null: false
    add_column :orders, :description, :string, null: false
    add_column :orders, :condition, :string, null: false
    add_column :orders, :category, :string, null: false
    add_column :orders, :price, :decimal, null: false
  end
end
