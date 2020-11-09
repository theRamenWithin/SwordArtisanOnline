class AddUsersRefToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :users, index: true, foreign_key: true
  end
end
