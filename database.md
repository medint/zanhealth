
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

Location
room string
floor integer
building string
facilities_id integer

Need
name string
location_id integer
model_id integer
quantity integer
urgency integer
reason text
remarks text
stage integer
date_requested date
user_id integer

Item
domain integer
tag integer
category string
model_id integer
serial_number string
year_manufactured integer
funding string
date_received date
warranty_expire date
contract_expire date
warranty_notes text
service_agent string
location_id integer
item_type integer
price integer

ItemHistory
item_id integer
datetime datetime
status integer
utilization integer
remarks text

WorkRequest
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

WorkRequestComment
datetime_stamp timestamp
work_request_id integer
user_id integer
comment_text text


Relations
=========

item has_many item_histories
item_history has_one item

work_request has_many work_request_comments
work_request_comment belongs_to work_request

work_request has_one item
item has_many work_requests

user has_many work_request_comments
work_request_comment belongs_to user

user has_many work_requests
work_request belongs_to user

user has_many needs
need belongs_to user

user has_one role
role has_many users

location belongs_to facility
facility has_many locations

location has_many items
item belongs_to location

location has_many needs
need belongs_to location

model has_many items
item belongs_to model

model has_many needs
need belongs_to model
