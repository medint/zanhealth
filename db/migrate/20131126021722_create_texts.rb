class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.string :number
      t.integer :bmet_work_order_id

      t.timestamps
    end
  end
end
