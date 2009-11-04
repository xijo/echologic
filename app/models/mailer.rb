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
  
  # Delivers activation instructions to the given user.
  # TODO i18n see view
  def activation_instructions(user)
    subject       I18n.t('users.activation.activation_mail.subject')
    from          "noreply@echologic.org"
    recipients    user.email
    sent_on       Time.now
    body          :name => user.display_name, :activation_url => register_url(user.perishable_token)
  end

  # Provides an activation for the given user.
  # TODO i18n see view
  def activation_confirmation(user)
    subject       I18n.t('users.activation.welcome_mail.subject')
    from          "noreply@echologic.org"
    recipients    user.email
    sent_on       Time.now
    body          :name => user.display_name
  end

  # Send a password reset email containing a link to reset via perishable_token.
  def password_reset_instructions(user)
    subject       I18n.t('users.password_reset.new_password_mail.subject')
    from          "noreply@echologic.org"
    recipients    user.email
    sent_on       Time.now
    body          :name => user.display_name, :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
