class ChangeNullAddresses < ActiveRecord::Migration[6.0]
  def change
    change_column_null :addresses, :street, true
    change_column_null :addresses, :city, true
    change_column_null :addresses, :state_or_province, true
    change_column_null :addresses, :postal_code, true
    change_column_null :addresses, :country, true
    change_column_null :addresses, :phone, true
  end
end
