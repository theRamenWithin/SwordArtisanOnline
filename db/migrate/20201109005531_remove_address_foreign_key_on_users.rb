class RemoveAddressForeignKeyOnUsers < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :users, :addresses
  end
end
