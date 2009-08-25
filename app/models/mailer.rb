class Mailer < ActionMailer::Base

  # Sends a feedback e-Mail to echo with the given parameters. If not
  # all information is provided an exception will raise.
  # Recipient specified through environment variable FEEBACK_RECIPIENT.
  def feedback(params, sent_at = Time.now)
    @body         = params[:text]
    @name         = params[:name]
    @sender        = params[:sender]
    if (@sender.empty? or @name.empty? or @body.empty?)
      raise FeedbackController::NotComplete
    end
    @subject      = "echologic feedback"
    @recipients   = FEEDBACK_RECIPIENT
    @from         = "#{@name} <#{@sender}>"
    @sent_on      = sent_at
    @content_type = 'text/html'
  end
  
  # Used to send an e-Mail when user joined
  def thank_you(params)
    puts params.inspect
    @body         = params[:body]
    @subject      = params[:subject]
    @recipients   = params[:email]
    @from         = "echologic <team@echo-logic.org>"
    @sent_on      = Time.now
    @content_type = 'text/html'
  end

  # Depricated at the moment while invitations are disabled.
  def invitation(invited_person)
    name          = InterestedPerson.find(invited_person.interested_person_id).name
    @body         = "Dear #{invited_person.name}, your knowee #{name} invited you to take a look on our project: echo - the global agora!"
    @subject      = "echologic invitation"
    @recipients   = invited_person.email
    @from         = "echologic <team@echo-logic.org>"
    @sent_on      = Time.now
    @content_type = 'text/html'
  end  

end
