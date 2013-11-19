
Datatypes

Rails datatypes:
:primary_key

:string
:text

:integer
:float
:decimal

:datetime
:timestamp
:time
:date

:binary
:boolean


items_histories
item_id INT :integer
datetime DATETIME :datetime
status ENUM(..) :integer
utilization ENUM(..) :integer
remarks TEXT :text

items
domain ENUM(..) :integer
tag INT :integer
category VARCHAR(255) :string
model_id INT :integer
serial_number VARCHAR(45) :string
year_manufactured INT :integer
funding VARCHAR(45) :string
date_received DATE :date
warranty_expire DATE :date
contract_expire DATE :date
warranty_notes TEXT :text
service_agent VARCHAR(45) :string
location_id INT :integer
item_type ENUM('Biomedical') :integer
price INT :integer

work_requests
date_requested DATETIME :datetime
date_expire DATETIME :datetime
date_completed DATETIME :datetime
request_type ENUM(..) :integer
item INT :integer
cost INT :integer
description TEXT :text
status ENUM(..) :integer
owner_id INT :integer
requester_id INT :integer
cause_description TEXT :text
action_taken TEXT :text
prevention_taken TEXT :text

facilities
name VARCHAR(255) :string

locations
floor INT :integer
building VARCHAR(50) :string
facilities_id INT :integer 

work_request_comments
datetime_stamp TIMESTAMP :timestamp
work_request_id INT :integer
user_id INT :integer 
comment_text TEXT :text

users
username VARCHAR(50) :string
password VARCHAR(60) :string
role_id INT :integer
created DATETIME :datetime
modified DATETIME :datetime
telephone_num INT :integer

roles
name VARCHAR(45) :string

models
manufacturer_name VARCHAR(255)
vendor_name VARCHAR(255)

needs
name VARCHAR(45)
quantity INT
urgency ENUM(..)
reason TEXT
remarks TEXT
stage ENUM(..)
date_requested DATE




