class AddDetailsToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :street, :string, null: false
    add_column :addresses, :city, :string, null: false
    add_column :addresses, :state, :string, null: false
    add_column :addresses, :state_or_province, :string, null: false
    add_column :addresses, :postal_code, :string, null: false
    add_column :addresses, :country, :string, null: false
    add_column :addresses, :phone, :string, null: false
  end
end
