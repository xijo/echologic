class Static::EchocracyController < ApplicationController
  
  # echocracy - The Benefits / The Actors
  def index
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echocracy' } }
    end
  end

  # echocracy - Citizens
  def citizens
    respond_to do |format|
      format.html { render :partial => 'citizens', :layout => 'application' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'citizens' } }            
    end
  end

  # echocracy - Scientists
  def scientists
    respond_to do |format|
      format.html { render :partial => 'scientists', :layout => 'application' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'scientists' } }            
    end
  end

  # echocracy - Decision makers
  def decision_makers
    respond_to do |format|
      format.html { render :partial => 'decision_makers', :layout => 'application' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'decision_makers' } }            
    end
  end

  # echocracy - Organisations
  def organisations
    respond_to do |format|
      format.html { render :partial => 'organisations', :layout => 'application' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'organisations' } }            
    end
  end

end
