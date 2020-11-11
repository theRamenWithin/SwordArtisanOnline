class RenameConditionsToConditionInOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :conditions, :condition
  end
end
