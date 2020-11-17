class ChangeColumnTypeForPhoneInListings < ActiveRecord::Migration[6.0]
  def change
    change_column :listings, :phone, :string
  end
end
