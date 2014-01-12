class DeleteTagFromItems < ActiveRecord::Migration
  def change
  	  remove_column :items, :tag
  end
end
