class CreateWorkRequestComments < ActiveRecord::Migration
  def change
    create_table :work_request_comments do |t|
      t.timestamp :datetime_stamp
      t.integer :work_request_id
      t.integer :user_id
      t.text :comment_text

      t.timestamps
    end
  end
end
