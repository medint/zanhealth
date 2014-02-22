
Models
======

Role
name string

User
username string
encrypted_password string
role_id integer
created datetime
modified datetime
telephone_num integer

Facility
name string

Model
model_name string
manufacturer_name string
vendor_name string

Department
name string
facilities_id integer

Need
name string
department_id integer
model_id integer
quantity integer
urgency integer
reason text
remarks text
stage integer
date_requested date
user_id integer

Item
asset_id string
model_id integer
serial_number string
year_manufactured integer
funding string
date_received date
warranty_expire date
contract_expire date
warranty_notes text
service_agent string
department_id integer
location string
item_type string
price integer

ItemHistory
item_id integer
datetime datetime
status integer
utilization integer
remarks text

BmetWorkOrder
date_requested datetime
date_expire datetime
date_completed datetime
request_type integer
item integer
cost integer
description text
status integer
owner_id integer
requester_id integer
cause_description text
action_taken text
prevention_taken text

BmetWorkOrderComment
datetime_stamp timestamp
bmet_work_order_id integer
user_id integer
comment_text text

Text
content text
number string
bmet_work_order_id integer


Relations
=========

item has_many item_histories
item_history has_one item

bmet_work_order has_many bmet_work_order_comments
bmet_work_order_comment belongs_to bmet_work_order

bmet_work_order has_one item
item has_many bmet_work_orders

user has_many bmet_work_order_comments
bmet_work_order_comment belongs_to user

user has_many bmet_work_orders
bmet_work_order belongs_to user

user has_many needs
need belongs_to user

user has_one role
role has_many users

department belongs_to facility
facility has_many departments

department has_many items
item belongs_to deparment

department has_many needs
need belongs_to department

model has_many items
item belongs_to model

model has_many needs
need belongs_to model

text belongs_to bmet_work_order
bmet_work_order has_many texts
