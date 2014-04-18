json.array!(@facility_work_order_comments) do |facility_work_order_comment|
  json.extract! facility_work_order_comment, :id, :datetime_stamp, :facility_work_order_id, :user_id, :comment_text
  json.url facility_work_order_comment_url(facility_work_order_comment, format: :json)
end
