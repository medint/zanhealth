class AddCreoleToLanguages < ActiveRecord::Migration
  def change
     add_column :languages, :creole, :string
  end
end
