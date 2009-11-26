class Static::EchoController < ApplicationController

  # echo - The Project
  def show
    respond_to do |format|
      format.html { render :partial => 'show', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echo - The Project
  def echo
    respond_to do |format|
      format.html { render :partial => 'echo', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo' } }
    end
  end

  # echo - Discuss
  def discuss
    respond_to do |format|
      format.html { render :partial => 'discuss', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'discuss' } }
    end
  end

  # echo - Connect
  def connect
    respond_to do |format|
      format.html { render :partial => 'connect', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'connect' } }
    end
  end

  # echo - Act
  def act
    respond_to do |format|
      format.html { render :partial => 'act', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'act' } }
    end
  end

  # echo - echo on waves
  def echo_on_waves
    respond_to do |format|
     # format.html
      format.html { render :partial => 'echo_on_waves', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' , :locals => { :menu_item => 'echo', :submenu_item => 'echo_on_waves' } }
    end
  end

end
