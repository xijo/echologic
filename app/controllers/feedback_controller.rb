# To handle smtp exceptions include the net/smtp-module.
require 'net/smtp'

# Error to indicate the feedback form wasn't filled out completely.
# Thrown by: mailer
class NotComplete < StandardError
end

class FeedbackController < ApplicationController

  # GET /feedback/new
  def new
    respond_to do |format|
      format.html { render :partial => 'feedback/new', :layout => 'static' }
      format.js
    end
  end  

  # POST /feedback
  def create
    @feedback = Feedback.new(params[:feedback])
    respond_to do |format|
      format.js do
        if @feedback.save
          Mailer.deliver_feedback(@feedback)
          render :template => 'feedback/create'
        else
          show_error_messages(@feedback)
        end
      end
    end
  end

  # Rescues eventually occuring errors and handles them by redirecting to
  # the feedback page with error message in the flash storage.
  # TODO errors as an array in flash, currently just one error per request.
  def rescue2_action(exception)
    case (exception)
      when NotComplete
        then flash[:error] = t('activerecord.errors.models.feedback.attributes.blank')
      when Net::SMTPSyntaxError
        then flash[:error] = t('activerecord.errors.models.feedback.attributes.email.invalid')
    end
    respond_to do |wants|
      wants.html { render :partial => 'feedback/new', :layout => 'static' }
      wants.js { render :template => 'layouts/outerMenuDialog', :locals => { :menu_item => 'feedback/new' }}
    end
  end

  
end
