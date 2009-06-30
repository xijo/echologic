class FeedbackMailer < ActionMailer::Base
  

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

end
