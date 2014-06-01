class AddStatusAndConditionToBmetItems < ActiveRecord::Migration
  def change
    add_column :bmet_items, :status, :integer
    add_column :bmet_items, :condition, :integer
    
    remove_column :bmet_items, :price, :integer
    add_column :bmet_items, :price, :decimal, precision: 5, scale: 2

  end
end
