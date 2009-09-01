class Static::EchoController < ApplicationController

  # echo - The Project
  def index
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo' } }
    end
  end

  # echo - The Project
  def echo
    respond_to do |format|
      format.html { render :partial => 'echo', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo' } }
    end
  end
  
  # echo - Discuss
  def discuss
    respond_to do |format|
      format.html { render :partial => 'discuss', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'discuss' } }
    end
  end

  # echo - Connect
  def connect
    respond_to do |format|
      format.html { render :partial => 'connect', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'connect' } }
    end
  end

  # echo - Act
  def act
    respond_to do |format|
      format.html { render :partial => 'act', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'act' } }
    end
  end
  
  # echo - echo on waves
  def echo_on_waves
    respond_to do |format|
     # format.html
      format.html { render :partial => 'echo_on_waves', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'echo_on_waves' } }
    end
  end

end
