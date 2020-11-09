class RemoveAddressesRefFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :address
  end
end
