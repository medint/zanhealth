class AddDomainToItems < ActiveRecord::Migration
  def change
    add_column :items, :domain, :string
  end
end
