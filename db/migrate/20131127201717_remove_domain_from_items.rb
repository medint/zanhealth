class RemoveDomainFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :domain
  end
end
