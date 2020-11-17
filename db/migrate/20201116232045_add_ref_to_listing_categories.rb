class AddRefToListingCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :listing_categories, :listing
    add_reference :listing_categories, :category
  end
end
