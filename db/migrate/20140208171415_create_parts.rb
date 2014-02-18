class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :p_id
      t.string :name
      t.string :category
      t.integer :quantity
      t.integer :minQ
      t.string :location
      #Here's the tricky one
      t.text :related
      t.string :needs

      t.timestamps
      end
  end
end
