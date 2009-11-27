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
      if current_user
        format.html { redirect_to welcome_path }
      else
        format.html { render :partial => 'show', :layout => 'static' }
        format.js { render :template => 'layouts/headContainer' }
      end
    end
  end

  # About
  def about
    respond_to do |format|
      format.html { render :partial => 'about', :layout => 'static', :locals => {:title => I18n.t('static.echologic.about.title')} }
      format.js { render :template => 'layouts/outerMenuDialog', :locals => {:title => I18n.t('static.echologic.about.title')} }
    end
  end

  # Imprint
  def imprint
    respond_to do |format|
      format.html { render :partial => 'imprint', :layout => 'static', :locals => {:title => I18n.t('static.echologic.imprint.title')} }
      format.js { render :template => 'layouts/outerMenuDialog', :locals => { :title => I18n.t('static.echologic.imprint.title')} }
    end
  end

  # Data privacy
  def data_privacy
    respond_to do |format|
      format.html { render :partial => 'data_privacy', :layout => 'static', :locals => { :title => I18n.t('static.echologic.data_privacy.title')} }
      format.js { render :template => 'layouts/outerMenuDialog', :locals => { :title => I18n.t('static.echologic.data_privacy.title')} }
    end
  end

end
