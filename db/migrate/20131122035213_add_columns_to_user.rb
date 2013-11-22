class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
  end
end
