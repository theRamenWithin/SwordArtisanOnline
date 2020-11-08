class AddDateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :purchase_date, :date
  end
end
