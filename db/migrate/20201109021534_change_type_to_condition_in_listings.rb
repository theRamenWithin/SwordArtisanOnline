class ChangeTypeToConditionInListings < ActiveRecord::Migration[6.0]
  def change
    rename_column :listings, :type, :condition
  end
end
