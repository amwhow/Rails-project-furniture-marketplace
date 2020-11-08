class AddColumnsToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :description, :text
    add_column :listings, :price, :float
    add_reference :listings, :user, foreign_key: true
    add_column :listings, :name, :string
    add_column :listings, :condition, :string
  end
end
