class CreateItemHistories < ActiveRecord::Migration
  def change
    create_table :item_histories do |t|
      t.integer :item_id
      t.datetime :datetime
      t.integer :status
      t.integer :utilization
      t.text :remarks

      t.timestamps
    end
  end
end
