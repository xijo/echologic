#
# Handles the echologic start page and all those one-static-pages like
# imprint and about.
# CHANGES:
#   28.08.2009 - Joe:
#     - created and refactored from StaticContentController
#     - index action now handles '/echologic'
#
class Static::EchologicController < ApplicationController

  # Default page redirected to echoLogic - The Mission
  def show
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'static' }
      format.js { render :template => 'layouts/headContainer' }
    end
  end
 
  # About
  def about
    respond_to do |format|
      format.html { render :partial => 'about', :layout => 'static' }
      format.js { render :template => 'layouts/outerMenuDialog' }
    end
  end

  # Imprint
  def imprint
    respond_to do |format|
      format.html { render :partial => 'imprint', :layout => 'static' }
      format.js { render :template => 'layouts/outerMenuDialog' }
    end
  end
  
  # Data privacy
  def data_privacy
    respond_to do |format|
      format.html { render :partial => 'data_privacy', :layout => 'static' }
      format.js { render :template => 'layouts/outerMenuDialog' }
    end
  end
  
end
