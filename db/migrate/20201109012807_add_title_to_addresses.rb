class AddTitleToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :title, :string, null: false
  end
end