Mapped from the DB diagram:

item has_many item_history
item_history has_one item

work_request has_many work_request_comments
work_request_comments belongs_to work_request

work_request has_one item
item has_many work_requests

user has_many work_request_comments
work_request_comment belongs_to user

user has_many work_requests
work_request belongs_to user

user has_many needs
need belongs_to user

user has_and_belongs_to_many roles
role has_and_belongs_to_many users

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


