class ChangeCategoryInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :category, :string, array: true, default: [], using: "(string_to_array(category, ','))"
    change_column :listings, :category, :string,  array: true, default: [], using: "(string_to_array(category, ','))"
  end
end
