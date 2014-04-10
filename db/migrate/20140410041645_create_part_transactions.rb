class CreatePartTransactions < ActiveRecord::Migration
  def change
    create_table :part_transactions do |t|
      t.integer :change_quantity
      t.datetime :date
      t.string :vendor
      t.integer :price
      t.references :part, index: true

      t.timestamps
    end
  end
end
