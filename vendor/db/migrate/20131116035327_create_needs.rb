class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.string :name
      t.integer :quantity
      t.integer :urgency
      t.text :reason
      t.text :remarks
      t.integer :stage
      t.date :date_requested

      t.timestamps
    end
  end
end
