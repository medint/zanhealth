class CreateFacilityWorkOrderComments < ActiveRecord::Migration
  def change
    create_table :facility_work_order_comments do |t|
      t.timestamp :datetime_stamp
      t.integer :work_request_id
      t.integer :user_id
      t.text :comment_text

      t.timestamps
    end
  end
end
