class ChangeColumnNameToListings < ActiveRecord::Migration[6.0]
  def change
    rename_column :listings, :name, :title
  end
end
