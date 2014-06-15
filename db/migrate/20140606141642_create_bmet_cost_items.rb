class CreateBmetCostItems < ActiveRecord::Migration
  def change
    create_table :bmet_cost_items do |t|
      t.string :name
      t.references :facility, index: true

      t.timestamps
    end
  end
end
