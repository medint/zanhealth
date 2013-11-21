class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.string :phone_number

      t.timestamps
    end
  end
end
