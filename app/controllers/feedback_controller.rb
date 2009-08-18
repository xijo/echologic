class NotComplete < StandardError
end

class NoText < StandardError
end

class FeedbackController < ApplicationController

  # GET /feedback/new
  def new
    respond_to do |format|
      format.html { render :partial => 'feedback/new', :layout => 'static' }
      format.js { render :template => 'static_content/outer_menu', :locals => { :menu_item => 'feedback/new' }}
    end
  end  

  # POST /feedback
  def create
    respond_to do |format|
      Mailer.deliver_feedback(params)
      format.html { redirect_to(echologic_path) }        
    end
  end
  
  def rescue_action(exception)
    case (exception)
      when NotComplete
        then flash[:error] = t('errors.feedback.' + exception.to_s.downcase)
      when NoText 
        then flash[:error] = t('errors.feedback.' + exception.to_s.downcase)
      when Net::SMTPSyntaxError
        then flash[:error] = t('errors.feedback.smtpsyntax')
      else
        flash[:error] = t('errors.feedback.unknown')
    end
    respond_to do |wants|
      wants.html { render :partial => 'feedback/new', :layout => 'static' }
      wants.js { render :template => 'static_content/outer_menu', :locals => { :menu_item => 'feedback/new' }}
    end
  end

  
end
