class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :english
      t.string :swahili

      t.timestamps
    end
  end
end
