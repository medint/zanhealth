# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140711124124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bmet_cost_items", force: true do |t|
    t.string   "name"
    t.integer  "facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bmet_cost_items", ["facility_id"], name: "index_bmet_cost_items_on_facility_id", using: :btree

  create_table "bmet_costs", force: true do |t|
    t.integer  "unit_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bmet_work_order_id"
    t.integer  "work_request_id"
    t.decimal  "cost",               precision: 12, scale: 2
    t.integer  "bmet_cost_item_id"
  end

  add_index "bmet_costs", ["bmet_cost_item_id"], name: "index_bmet_costs_on_bmet_cost_item_id", using: :btree

  create_table "bmet_item_histories", force: true do |t|
    t.integer  "bmet_item_id"
    t.integer  "bmet_item_status"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "work_order_id"
    t.integer  "bmet_item_condition"
    t.integer  "work_order_status"
  end

  create_table "bmet_items", force: true do |t|
    t.integer  "bmet_model_id"
    t.string   "serial_number"
    t.integer  "year_manufactured"
    t.string   "funding"
    t.date     "date_received"
    t.date     "warranty_expire"
    t.date     "contract_expire"
    t.text     "warranty_notes"
    t.string   "service_agent"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_id"
    t.string   "location"
    t.integer  "status"
    t.integer  "condition"
    t.decimal  "price",             precision: 5, scale: 2
    t.string   "short_url_key"
    t.string   "notes"
  end

  create_table "bmet_labor_hours", force: true do |t|
    t.datetime "date_started"
    t.integer  "technician_id"
    t.integer  "bmet_work_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "duration",           precision: 8, scale: 3
  end

  create_table "bmet_models", force: true do |t|
    t.string   "model_name"
    t.string   "manufacturer_name"
    t.string   "vendor_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.integer  "facility_id"
    t.integer  "item_group_id"
  end

  add_index "bmet_models", ["facility_id"], name: "index_bmet_models_on_facility_id", using: :btree
  add_index "bmet_models", ["item_group_id"], name: "index_bmet_models_on_item_group_id", using: :btree

  create_table "bmet_needs", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.integer  "bmet_model_id"
    t.integer  "quantity"
    t.integer  "urgency"
    t.text     "reason"
    t.text     "remarks"
    t.integer  "stage"
    t.date     "date_requested"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bmet_preventative_maintenances", force: true do |t|
    t.datetime "last_date_checked"
    t.integer  "days"
    t.integer  "weeks"
    t.integer  "months"
    t.datetime "next_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requester_id"
    t.datetime "deleted_at"
    t.integer  "bmet_item_id"
  end

  add_index "bmet_preventative_maintenances", ["bmet_item_id"], name: "index_bmet_preventative_maintenances_on_bmet_item_id", using: :btree
  add_index "bmet_preventative_maintenances", ["deleted_at"], name: "index_bmet_preventative_maintenances_on_deleted_at", using: :btree

  create_table "bmet_work_order_comments", force: true do |t|
    t.datetime "datetime_stamp"
    t.integer  "bmet_work_order_id"
    t.integer  "user_id"
    t.text     "comment_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bmet_work_orders", force: true do |t|
    t.datetime "date_requested"
    t.datetime "date_expire"
    t.datetime "date_completed"
    t.integer  "request_type"
    t.integer  "bmet_item_id"
    t.integer  "cost"
    t.text     "description"
    t.integer  "status"
    t.integer  "owner_id"
    t.integer  "requester_id"
    t.text     "cause_description"
    t.text     "action_taken"
    t.text     "prevention_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_started"
    t.integer  "department_id"
    t.datetime "deleted_at"
    t.integer  "pm_origin_id"
    t.integer  "wr_origin_id"
    t.integer  "priority"
  end

  add_index "bmet_work_orders", ["deleted_at"], name: "index_bmet_work_orders_on_deleted_at", using: :btree

  create_table "bmet_work_requests", force: true do |t|
    t.text     "requester"
    t.text     "department"
    t.text     "location"
    t.text     "phone"
    t.text     "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id"
    t.datetime "deleted_at"
    t.integer  "wo_convert_id"
    t.datetime "converted_at"
    t.string   "asset_id"
    t.boolean  "unread"
  end

  add_index "bmet_work_requests", ["deleted_at"], name: "index_bmet_work_requests_on_deleted_at", using: :btree
  add_index "bmet_work_requests", ["facility_id"], name: "index_bmet_work_requests_on_facility_id", using: :btree

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id"
  end

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
  end

  create_table "facility_cost_items", force: true do |t|
    t.string   "name"
    t.integer  "facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facility_cost_items", ["facility_id"], name: "index_facility_cost_items_on_facility_id", using: :btree

  create_table "facility_costs", force: true do |t|
    t.integer  "unit_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_work_order_id"
    t.decimal  "cost",                   precision: 12, scale: 2
    t.integer  "facility_cost_item_id"
  end

  add_index "facility_costs", ["facility_cost_item_id"], name: "index_facility_costs_on_facility_cost_item_id", using: :btree
  add_index "facility_costs", ["facility_work_order_id"], name: "index_facility_costs_on_facility_work_order_id", using: :btree

  create_table "facility_labor_hours", force: true do |t|
    t.datetime "date_started"
    t.integer  "duration"
    t.integer  "technician_id"
    t.integer  "facility_work_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facility_labor_hours", ["facility_work_order_id"], name: "index_facility_labor_hours_on_facility_work_order_id", using: :btree

  create_table "facility_preventative_maintenances", force: true do |t|
    t.datetime "last_date_checked"
    t.integer  "days"
    t.integer  "weeks"
    t.integer  "months"
    t.datetime "next_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.datetime "deleted_at"
    t.integer  "requester_id"
  end

  add_index "facility_preventative_maintenances", ["deleted_at"], name: "index_facility_preventative_maintenances_on_deleted_at", using: :btree

  create_table "facility_work_order_comments", force: true do |t|
    t.datetime "datetime_stamp"
    t.integer  "facility_work_order_id"
    t.integer  "user_id"
    t.text     "comment_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facility_work_order_comments", ["facility_work_order_id"], name: "index_facility_work_order_comments_on_facility_work_order_id", using: :btree

  create_table "facility_work_orders", force: true do |t|
    t.datetime "date_expire"
    t.datetime "date_completed"
    t.integer  "request_type"
    t.text     "description"
    t.integer  "status"
    t.integer  "owner_id"
    t.integer  "requester_id"
    t.text     "cause_description"
    t.text     "action_taken"
    t.text     "prevention_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_started"
    t.integer  "department_id"
    t.datetime "deleted_at"
    t.integer  "pm_origin_id"
    t.integer  "wr_origin_id"
  end

  add_index "facility_work_orders", ["deleted_at"], name: "index_facility_work_orders_on_deleted_at", using: :btree
  add_index "facility_work_orders", ["department_id"], name: "index_facility_work_orders_on_department_id", using: :btree

  create_table "facility_work_requests", force: true do |t|
    t.text     "requester"
    t.text     "department"
    t.text     "location"
    t.text     "phone"
    t.text     "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id"
    t.datetime "deleted_at"
    t.integer  "wo_convert_id"
    t.datetime "converted_at"
  end

  add_index "facility_work_requests", ["deleted_at"], name: "index_facility_work_requests_on_deleted_at", using: :btree

  create_table "item_groups", force: true do |t|
    t.string   "name"
    t.integer  "facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_groups", ["facility_id"], name: "index_item_groups_on_facility_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "english"
    t.string   "swahili"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creole"
  end

  create_table "part_transactions", force: true do |t|
    t.integer  "change_quantity"
    t.datetime "date"
    t.string   "vendor"
    t.integer  "price"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_transactions", ["part_id"], name: "index_part_transactions_on_part_id", using: :btree

  create_table "parts", force: true do |t|
    t.integer  "p_id"
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.integer  "minQ"
    t.string   "location"
    t.text     "related"
    t.string   "needs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts_inventory", force: true do |t|
    t.integer  "p_id"
    t.string   "name"
    t.string   "manufacturer"
    t.string   "category"
    t.integer  "currentQuantity"
    t.integer  "minQuantity"
    t.string   "location"
    t.text     "related"
    t.text     "actions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shortened_urls", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type", limit: 20
    t.string   "url",                               null: false
    t.string   "unique_key", limit: 10,             null: false
    t.integer  "use_count",             default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "asset_id"
  end

  add_index "shortened_urls", ["owner_id", "owner_type"], name: "index_shortened_urls_on_owner_id_and_owner_type", using: :btree
  add_index "shortened_urls", ["unique_key"], name: "index_shortened_urls_on_unique_key", unique: true, using: :btree
  add_index "shortened_urls", ["url"], name: "index_shortened_urls_on_url", using: :btree

  create_table "staging_items", force: true do |t|
    t.string  "serial_number"
    t.integer "year_manufactured"
    t.string  "funding"
    t.date    "date_received"
    t.date    "warranty_expire"
    t.date    "contract_expire"
    t.text    "warranty_notes"
    t.string  "service_agent"
    t.string  "department_name"
    t.decimal "price"
    t.string  "asset_id"
    t.string  "location"
    t.string  "model_name"
    t.string  "manufacturer_name"
    t.string  "vendor_name"
    t.string  "status"
    t.string  "condition"
    t.integer "facility_id"
    t.string  "short_url_key"
    t.string  "notes"
    t.string  "category"
  end

  create_table "staging_models", force: true do |t|
    t.string  "model_name"
    t.string  "manufacturer_name"
    t.string  "vendor_name"
    t.integer "facility_id"
    t.string  "item_group"
    t.string  "category"
  end

  create_table "texts", force: true do |t|
    t.text     "content"
    t.string   "number"
    t.integer  "bmet_work_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "role_id"
    t.integer  "telephone_num"
    t.integer  "facility_id"
    t.string   "language"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["facility_id"], name: "index_users_on_facility_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
