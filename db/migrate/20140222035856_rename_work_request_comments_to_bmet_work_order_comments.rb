class RenameWorkRequestCommentsToBmetWorkOrderComments < ActiveRecord::Migration
  def change
  	  rename_table :work_request_comments, :bmet_work_order_comments
  end
end
