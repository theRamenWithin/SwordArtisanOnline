class AddDetailsToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :title, :string, null: false
    add_column :listings, :description, :text, null: false
    add_column :listings, :type, :string, null: false
    add_column :listings, :category, :string, null: false
    add_column :listings, :price, :decimal, null: false
  end
end
