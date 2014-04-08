class DropTableusers < ActiveRecord::Migration
  def up
     drop_table :users
  end
  
  def down
     create_table "users" do |t|
       t.string   "username"
       t.string   "encrypted_password"
       t.integer  "role_id"
       t.datetime "created"
       t.datetime "modified"
       t.integer  "telephone_num"
       t.datetime "created_at"
       t.datetime "updated_at"
       t.integer  "facility_id"
       t.string   "language"
       t.string   "name"
     end
  end
end
