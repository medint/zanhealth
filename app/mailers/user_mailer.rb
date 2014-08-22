class UserMailer < ActionMailer::Base
  default from: "info@zanhealth.co"

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
  	mail(to: workrequest.email, subject: 'Work request ' + workrequest.id.to_s + ' has been completed')
  end

  def work_order_assigned_email(workorder)
    @workorder = workorder
    if Rails.env.development?
      @host = "localhost:3000"
    elsif Rails.env.production?
      @host = "zanhealth.co"
    end
    attachments["workorder.pdf"] = WorkOrderPdf.new(@workorder).render
    mail(to: workorder.owner.email, subject: 'You have been assigned to Work Order ' + workorder.id.to_s)
  end

  def work_order_completed_email(workorder)
    @workorder = workorder
    mail(to: workorder.owner.email, subject: 'Work Order ' + workorder.id.to_s + ' has been completed')
  end

end
