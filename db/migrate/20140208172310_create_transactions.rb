class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :partsTransactions do |t|
      t.integer :db_id
      t.integer :parts_id
      t.integer :changeQ
      t.datetime :date
      t.string :vendor
      t.integer :price

      t.timestamps
    end
  end
end
