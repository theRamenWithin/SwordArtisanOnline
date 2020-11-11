class RemovePurchaseDateFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :purchase_date
  end
end
