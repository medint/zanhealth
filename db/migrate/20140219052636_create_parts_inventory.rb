class CreatePartsInventory < ActiveRecord::Migration
  def change
    create_table :parts_inventory do |t|
      t.integer :p_id
      t.string :name
      t.string :manufacturer
      t.string :category
      t.integer :currentQuantity
      t.integer :minQuantity
      t.string :location
      t.text :related
      t.text :actions

      t.timestamps
    end
  end
end
