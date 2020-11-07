class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.boolean :delivery
      t.string :location

      t.timestamps
    end
  end
end
