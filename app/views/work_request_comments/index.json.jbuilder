json.array!(@work_request_comments) do |work_request_comment|
  json.extract! work_request_comment, :datetime_stamp, :comment_text
  json.url work_request_comment_url(work_request_comment, format: :json)
end
