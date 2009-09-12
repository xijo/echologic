# To handle smtp exceptions include the net/smtp-module.
require 'net/smtp'

# Error to indicate the feedback form wasn't filled out completely.
# Thrown by: mailer
class NotComplete < StandardError
end

class FeedbackController < ApplicationController

  # GET /feedback/new
  def new
    flash[:error] = ""
    respond_to do |format|
      format.html { render :partial => 'feedback/new', :layout => 'application' }
      format.js { render :template => 'layouts/headContainer' }
#      format.js { render :template => 'static_content/outer_menu', :locals => { :menu_item => 'feedback/new' }}
    end
  end  

  # POST /feedback
  def create
    respond_to do |format|
      Mailer.deliver_feedback(params)
      flash[:notice] = 'feedback.create.thank_you'
      format.html { redirect_to(echologic_path) }        
    end
  end

  # Rescues eventually occuring errors and handles them by redirecting to
  # the feedback page with error message in the flash storage.
  # TODO errors as an array in flash, currently just one error per request.
  def rescue_action(exception)
    case (exception)
      when NotComplete
        then flash[:error] = t('activerecord.errors.models.feedback.attributes.blank')
      when Net::SMTPSyntaxError
        then flash[:error] = t('activerecord.errors.models.feedback.attributes.email.invalid')
    end
    respond_to do |wants|
      wants.html { render :partial => 'feedback/new', :layout => 'application' }
      wants.js { render :template => 'static_content/outer_menu', :locals => { :menu_item => 'feedback/new' }}
    end
  end

  
end
