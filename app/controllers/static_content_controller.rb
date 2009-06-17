class StaticContentController < ApplicationController
  
  # Default page redirected to echoLogic - The Mission
  def index
    redirect_to (:action => 'echologic')
  end
  
  # Start page: echoLogic - The Mission
  def echologic
    respond_to do |format|
      format.html
    end
  end
  
  # echo - The Platform
  def echo
    respond_to do |format|
      format.html { render :partial => 'static_content/echo', :layout => 'static' }
    end
  end
  
  # echo - Discuss
  def echo_discuss
    respond_to do |format|
      format.html { render :partial => 'static_content/discuss', :layout => 'static' }
    end
  end

  #echo - Connect
  def echo_connect
    respond_to do |format|
      format.html { render :partial => 'static_content/connect', :layout => 'static' }
    end
  end

  #echo - Act
  def echo_act
    respond_to do |format|
      format.html { render :partial => 'static_content/act', :layout => 'static' }
    end
  end
  
  # echocracy - The Actors
  def echocracy
    respond_to do |format|
      format.html { render :partial => 'static_content/echocracy', :layout => 'static' }
    end
  end

  # echocracy - Engaged Citizens
  def echocracy_citizens
    respond_to do |format|
      format.html { render :partial => 'static_content/citizens', :layout => 'static' }
    end
  end
  
  # echocracy - Experts & Scientists
  def echocracy_experts
    respond_to do |format|
      format.html { render :partial => 'static_content/experts', :layout => 'static' }
    end
  end
  
  # echocracy - NGOs & Political Organisations
  def echocracy_organisations
    respond_to do |format|
      format.html { render :partial => 'static_content/organisations', :layout => 'static' }
    end
  end
  
  # echonomy - The Philosophy
  def echonomy
    respond_to do |format|
      format.html { render :partial => 'static_content/echonomy', :layout => 'static' }
    end
  end
  
  # echonomy - Your-profit
  def echonomy_business_model
    respond_to do |format|
      format.html { render :partial => 'static_content/business_model', :layout => 'static' }
    end
  end

  # echonomy - Open Source
  def echonomy_open_source
    respond_to do |format|
      format.html { render :partial => 'static_content/open_source', :layout => 'static' }
    end
  end
  
  # echonomy - Public Property
  def echonomy_public_property
    respond_to do |format|
      format.html { render :partial => 'static_content/public_property', :layout => 'static' }
    end    
  end
  
end
