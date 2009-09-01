#
# Handles the echologic start page and all those one-static-pages like
# imprint and about.
# CHANGES:
#   28.08.2009 - Joe:
#     - created and refactored from StaticContentController
#     - index action now handles '/echologic'
# TODO: edit javascript answers
#
class Static::EchologicController < ApplicationController

  # Default page redirected to echoLogic - The Mission
  def index
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'application' }
      format.js { render :template => 'layouts/headContainer' }
    end
  end
 
  # About
  def about
    respond_to do |format|
      format.html { render :partial => 'about', :layout => 'application' }
      format.js { render :template => 'layouts/headContainer', :locals => { :menu_item => 'about' }}
    end
  end

  # Imprint
  def imprint
    respond_to do |format|
      format.html { render :partial => 'imprint', :layout => 'application' }
      format.js { render :template => 'layouts/headContainer', :locals => { :menu_item => 'imprint' }}
    end
  end
  
  # Data privacy
  def data_privacy
    respond_to do |format|
      format.html { render :partial => 'data_privacy', :layout => 'application' }
      format.js { render :template => 'layouts/headContainer', :locals => { :menu_item => 'data_privacy' }}
    end
  end
  
end
