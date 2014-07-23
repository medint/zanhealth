class RequesterMailer < ActionMailer::Base
  default from: "automatedMEDemails@gmail.com"

  def work_request_received_email(workrequest)
  	@workrequest = workrequest
  	mail(to: workrequest.email, subject: 'Work request ' + workrequest.id.to_s + ' has been received' )
  end

  def work_request_converted_email(workrequest)
  	@workrequest = workrequest
  	mail(to: workrequest.email, subject: 'Work request ' + workrequest.id.to_s + ' has been processed')
  end

  def work_request_completed_email(workrequest)
  	@workrequest = workrequest
  	mail(to: workrequest.email, subject: 'Work request' + workrequest.id.to_s + 'has been completed')
  end

end
