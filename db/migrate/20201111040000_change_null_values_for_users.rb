class ChangeNullValuesForUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :email, true
    change_column_null :users, :username, true
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
    change_column_null :users, :date_of_birth, true
    change_column_null :users, :admin?, true
  end
end
