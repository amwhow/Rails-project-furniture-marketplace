class AddPhoneToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :phone, :integer
  end
end
