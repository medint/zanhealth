
Datatypes in Rails

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
datetime DATETIME :datetime
status ENUM(..) :integer
utilization ENUM(..) :integer
remarks TEXT :text

items
domain ENUM(..) :integer
tag INT :integer
category VARCHAR(255) :string
serial_number VARCHAR(45) :string
year_manufactured INT :integer
funding VARCHAR(45) :string
date_received DATE :date
warranty_expire DATE :date
contract_expire DATE :date
warranty_notes TEXT :text
service_agent VARCHAR(45) :string
item_type ENUM('Biomedical') :integer
price INT :integer

work_requests
date_requested DATETIME :datetime
date_expire DATETIME :datetime
date_completed DATETIME :datetime
request_type ENUM(..) :integer
cost INT :integer
description TEXT :text
status ENUM(..) :integer
requester_id INT :integer
cause_description TEXT :text
action_taken TEXT :text
prevention_taken TEXT :text

facilities
name VARCHAR(255) :string

locations
floor INT :integer
building VARCHAR(50) :string

work_request_comments
datetime_stamp TIMESTAMP :timestamp
comment_text TEXT :text

users
username VARCHAR(50) :string
password VARCHAR(60) :string
created DATETIME :datetime
modified DATETIME :datetime
telephone_num INT :integer

roles
name VARCHAR(45) :string

models
manufacturer_name VARCHAR(255) :string
vendor_name VARCHAR(255) :string

needs
name VARCHAR(45) :string
quantity INT :integer
urgency ENUM(..) :integer
reason TEXT :text
remarks TEXT :text
stage ENUM(..) :integer
date_requested DATE :date



