
This was generated using the following regex:
/\n((?<=\n)[a-z][^ ]+) [^:]+(.+)/ => / \1\2/
/\n([A-Z])/ => /\nrails g scaffold \1/

rails g scaffold ItemHistory datetime:datetime status:integer utilization:integer remarks:text

rails g scaffold Item domain:integer tag:integer category:string serial_number:string year_manufactured:integer funding:string date_received:date warranty_expire:date contract_expire:date warranty_notes:text service_agent:string item_type:integer price:integer

rails g scaffold WorkRequest date_requested:datetime date_expire:datetime date_completed:datetime request_type:integer cost:integer description:text status:integer requester_id:integer cause_description:text action_taken:text prevention_taken:text

rails g scaffold Facility name:string

rails g scaffold Location floor:integer building:string

rails g scaffold WorkRequestComment datetime_stamp:timestamp comment_text:text

rails g scaffold User username:string password:string created:datetime modified:datetime telephone_num:integer

rails g scaffold Role name:string

rails g scaffold Model manufacturer_name:string vendor_name:string

rails g scaffold Need name:string quantity:integer urgency:integer reason:text remarks:text stage:integer date_requested:date





