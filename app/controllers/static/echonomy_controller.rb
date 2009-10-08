class Static::EchonomyController < ApplicationController

  # echonomy - The Values
  def show
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echonomy - Your-Profit
  def your_profit
    respond_to do |format|
      format.html { render :partial => 'your_profit', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echonomy - Foundation
  def foundation
    respond_to do |format|
      format.html { render :partial => 'foundation', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echonomy - Public Property
  def public_property
    respond_to do |format|
      format.html { render :partial => 'public_property', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end
  
end