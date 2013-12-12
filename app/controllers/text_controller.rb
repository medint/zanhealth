class TextController < ApplicationController
  def receive
	message_body = params["Body"]
    from_number = params["From"]
	message = message_body.split("#")
	if message.first == "item"
		request = workRequest.create(:id => message_body.second)
		workRequestComment.create(:work_request_id => request.id,:comment_text => message.third)
	else
		comment = workRequestComment.create(:work_request_id => message.second, :comment_text => message.fourth)
		#if comment.work_request.status != message.third
			#comment.work_request.status => message.third
		#end
	end
    SMSLogger.log_text_message from_number, message_body
  end
end
