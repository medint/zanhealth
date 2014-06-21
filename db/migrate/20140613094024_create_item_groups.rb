class CreateItemGroups < ActiveRecord::Migration
  def change
    create_table :item_groups do |t|
      t.string :name
      t.references :facility, index: true
      t.timestamps
    end
  end
end
