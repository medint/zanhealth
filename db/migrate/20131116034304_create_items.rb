class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :domain
      t.integer :tag
      t.string :category
      t.string :serial_number
      t.integer :year_manufactured
      t.string :funding
      t.date :date_received
      t.date :warranty_expire
      t.date :contract_expire
      t.text :warranty_notes
      t.string :service_agent
      t.integer :item_type
      t.integer :price

      t.timestamps
    end
  end
end
