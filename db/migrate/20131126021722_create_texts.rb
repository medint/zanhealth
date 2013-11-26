class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.string :number
      t.integer :work_request_id

      t.timestamps
    end
  end
end
