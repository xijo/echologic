class Mailer < ActionMailer::Base

  # Sends a feedback e-Mail to echo with the given parameters. If not
  # all information is provided an exception will raise.
  # Recipient specified through environment variable FEEBACK_RECIPIENT.
  def feedback(params, sent_at = Time.now)
    #@body         = params[:text]
    @name         = params[:name]
    @sender        = params[:sender]
    if (@sender.empty? or @name.empty?)
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

  # Delivers activation instructions to the given user.
  # TODO i18n see view
  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "echologic <noreply@echo-logic.org>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  # Provides an activation for the given user.
  # TODO i18n see view
  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "echologic <noreply@echo-logic.org>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  # Send a password reset email containing a link to reset via perishable_token.
  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "echologic <noreply@echo-logic.org>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
