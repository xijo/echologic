class StaticContentController < ApplicationController
  
  # Default page redirected to echoLogic - The Mission
  def index
    redirect_to(:action => 'echologic')
  end
  
  # Start page: echoLogic - The Mission
  def echologic
    respond_to do |format|
      format.html { render :partial => 'static_content/echologic', :layout => 'static' }
      format.js
    end
  end
  
  # echo - The Platform
  def echo
    respond_to do |format|
      format.html { render :partial => 'static_content/echo', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo' } }            
    end
  end
  
  # echo - Discuss
  def echo_discuss
    respond_to do |format|
      format.html { render :partial => 'static_content/echo_discuss', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo', :submenu_item => 'discuss' } }
    end
  end

  #echo - Connect
  def echo_connect
    respond_to do |format|
      format.html { render :partial => 'static_content/echo_connect', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo', :submenu_item => 'connect' } }      
    end
  end

  #echo - Act
  def echo_act
    respond_to do |format|
      format.html { render :partial => 'static_content/echo_act', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo', :submenu_item => 'act' } }
    end
  end
  
  # echocracy - The Vision
  def echocracy
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy' } } 
    end
  end

  # echocracy - Actors
  def echocracy_actors
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy_actors', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'actors' } }            
    end
  end

  # echocracy - Synergy
  def echocracy_synergy
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy_synergy', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'synergy' } }            
    end
  end

  # echonomy - Your Profit
  def echonomy
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy' } }     
    end
  end
  
  # echonomy - Foundation
  def echonomy_foundation
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy_foundation', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy', :submenu_item => 'foundation' } }            
    end
  end
  
  # echonomy - Fundraising
  def echonomy_fundraising
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy_fundraising', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy', :submenu_item => 'fundraising' } }            
    end
  end
  
  # meta menu content
  
  # imprint
  def imprint
    respond_to do |format|
      format.html { render :template => 'static_content/imprint', :layout => 'static' }
      format.js
    end
  end
  
  
end
