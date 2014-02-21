class CreateBmetWorkOrderComments < ActiveRecord::Migration
  def change
    create_table :bmet_work_order_comments do |t|
      t.timestamp :datetime_stamp
      t.integer :bmet_work_order_id
      t.integer :user_id
      t.text :comment_text

      t.timestamps
    end
  end
end
