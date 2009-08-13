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
    FeedbackMailer.deliver_feedback(params)
    respond_to do |format|
      format.html { render :template => 'feedback/create', :layout => 'static' }
    end
  end
  
end
