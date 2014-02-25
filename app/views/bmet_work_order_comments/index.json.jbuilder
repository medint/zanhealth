json.array!(@bmet_work_order_comments) do |bmet_work_order_comment|
  json.extract! bmet_work_order_comment, :datetime_stamp, :bmet_work_order_id, :user_id, :comment_text
  json.url bmet_work_order_comment_url(bmet_work_order_comment, format: :json)
end
