class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :username, :string, null: false, index: true, unique: true
  end
end
