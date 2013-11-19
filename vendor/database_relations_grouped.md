

As they appear in Rails:


a facility has_many locations

an item has_many item_history
an item has_many work_requests
an item belongs_to location
an item belongs_to model

an item_history has_one item

a location has_many items
a location belongs_to facility
a location has_many needs

a model has_many items
a model has_many needs

a need belongs_to user
a need belongs_to location
a need belongs_to model

a role has_and_belongs_to_many users

a user has_many work_request_comments
a user has_many work_requests
a user has_many needs
a user has_and_belongs_to_many roles

a work_request has_many work_request_comments
a work_request has_one item
a work_request belongs_to user

a work_request_comment belongs_to work_request
a work_request_comment belongs_to user
