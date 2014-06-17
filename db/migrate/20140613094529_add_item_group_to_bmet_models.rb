class AddItemGroupToBmetModels < ActiveRecord::Migration
  def change
    add_reference :bmet_models, :item_group, index: true
  end
end
