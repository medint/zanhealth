class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :role_id, :integer
    add_column :users, :telephone_num, :integer
    add_reference :users, :facility, index: true
    add_column :users, :language, :string
    add_column :users, :name, :string
  end
end
