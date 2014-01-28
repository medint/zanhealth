class TextController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def receive
	message_body = params["Body"]
    from_number = params["From"]
	puts "Message body is %s." %message_body
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
  
  def create
	message_body = params["Body"]
    from_number = params["From"]
	puts "Message body is %s." %message_body
	message = message_body.split("#")
	if message.first == "item"
		request = workRequest.create(:id => message_body.second)
		workRequestComment.create(:work_request_id => request.id,:comment_text => message.third)
	else
		#comment = workRequestComment.create(:work_request_id => message.second, :comment_text => message.fourth)
		#if comment.work_request.status != message.third
			#comment.work_request.status => message.third
		#end
	end
    twilio_sid = "ACf72c38869b3c8ab18d652d77ebd15f46"
    twilio_token = "5f816594860aa6ab0acb97e75e2a207b"
    twilio_phone_number = "+14012845934"
	puts "sending message"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => "+#{from_number}",
      :body => "Message received. It gets sent to #{from_number}"
    )
  end
  
  def index
  end
end
