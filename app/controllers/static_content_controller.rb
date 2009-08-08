class StaticContentController < ApplicationController
  
  # Default page redirected to echoLogic - The Mission
  def index
    redirect_to(:action => 'echologic')
  end
  
  # Start page: echoLogic - The Mission
  def echologic
    respond_to do |format|
      format.html { render :partial => 'static_content/echologic', :layout => 'static' }
      format.js { render :template => 'static_content/echologic' }
    end
  end
  
  # echo - The Project
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

  # echo - Connect
  def echo_connect
    respond_to do |format|
      format.html { render :partial => 'static_content/echo_connect', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo', :submenu_item => 'connect' } }      
    end
  end

  # echo - Act
  def echo_act
    respond_to do |format|
      format.html { render :partial => 'static_content/echo_act', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo', :submenu_item => 'act' } }
    end
  end
  
  # echo - echo on waves
  def echo_echo_on_waves
    respond_to do |format|
      format.html { render :partial => 'static_content/echo_echo_on_waves', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echo', :submenu_item => 'echo_on_waves' } }
    end
  end
  
  # echocracy - The Benefits / The Actors
  def echocracy
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy' } } 
    end
  end

  # echocracy - Citizens
  def echocracy_citizens
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy_citizens', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'citizens' } }            
    end
  end

  # echocracy - Scientists
  def echocracy_scientists
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy_scientists', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'scientists' } }            
    end
  end

  # echocracy - Decision makers
  def echocracy_decision_makers
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy_decision_makers', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'decision_makers' } }            
    end
  end

  # echocracy - Organisations
  def echocracy_organisations
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy_organisations', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echocracy', :submenu_item => 'organisations' } }            
    end
  end

  # echonomy - The Values
  def echonomy
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy' } }     
    end
  end
  
  # echonomy - Your-Profit
  def echonomy_your_profit
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy_your_profit', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy', :submenu_item => 'your_profit' } }            
    end
  end
  
  # echonomy - Foundation
  def echonomy_foundation
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy_foundation', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy', :submenu_item => 'foundation' } }            
    end
  end
  
  # echonomy - Public Property
  def echonomy_public_property
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy_public_property', :layout => 'static' }
      format.js { render :template => 'static_content/static_content' , :locals => { :menu_item => 'echonomy', :submenu_item => 'public_property' } }            
    end
  end
  
  # Bottom menu
  
  # Imprint
  def imprint
    respond_to do |format|
      format.html { render :partial => 'static_content/imprint', :layout => 'static' }
      format.js { render :template => 'static_content/outer_menu', :locals => { :menu_item => 'imprint' }}
    end
  end
  
  # Data privacy
  def data_privacy
    respond_to do |format|
      format.html { render :partial => 'static_content/data_privacy', :layout => 'static' }
      format.js { render :template => 'static_content/outer_menu', :locals => { :menu_item => 'data_privacy' }}
    end
  end
  
end
