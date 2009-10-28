class Mailer < ActionMailer::Base

  # Send a feedback object as email to the FEEDBACK_RECIPIENT specified
  # in the environment.
  def feedback(feedback)
    @feedback     = feedback
    @subject      = "echologic feedback from #{@feedback.name}"
    @recipients   = FEEDBACK_RECIPIENT
    @from         = "feedback@echologic.org"
    @sent_on      = Time.now
    @content_type = 'text/html'
  end
  
  # Used to send an e-Mail when user joined
  def thank_you(params)
    puts params.inspect
    @body         = params[:body]
    @subject      = params[:subject]
    @recipients   = params[:email]
    @from         = "echologic <team@echologic.org>"
    @sent_on      = Time.now
    @content_type = 'text/html'
  end

  # Delivers activation instructions to the given user.
  # TODO i18n see view
  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "noreply@echologic.org"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  # Provides an activation for the given user.
  # TODO i18n see view
  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "noreply@echologic.org"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  # Send a password reset email containing a link to reset via perishable_token.
  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "noreply@echologic.org"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
