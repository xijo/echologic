class Mailer < ActionMailer::Base

  def feedback(params, sent_at = Time.now)
    @text         = params[:text]
    @name         = params[:name]
    @sender        = params[:sender]
    @subject      = "echologic feedback"
    @recipients   = 'johannes.opper@echo-logic.org'
    @from         = "#{@name} <#{@sender}>"
    @sent_on      = sent_at
    @content_type = 'text/html'
  end
  
  def thank_you(interested_person)
    @body         = "Dear #{interested_person.name}"
    @subject      = "echologic thank you"
    @recipients   = interested_person.email
    @from         = "noreply@echo-logic.org echologic"
    @sent_on      = Time.now
    @content_type = 'text/html'
  end
  
  def invitation(invited_person)
    name          = InterestedPerson.find(invited_person.interested_person_id).name
    @body         = "Dear #{invited_person.name}, your knowee #{name} invited you to take a look on our project: echo - the global agora!"
    @subject      = "echologic invitation"
    @recipients   = invited_person.email
    @from         = "noreply@echo-logic.org echologic"
    @sent_on      = Time.now
    @content_type = 'text/html'
  end  

end
