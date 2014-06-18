class AddNotesToBmetItems < ActiveRecord::Migration
  def change
    add_column :bmet_items, :notes, :string
  end
end
