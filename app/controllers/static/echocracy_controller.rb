class Static::EchocracyController < ApplicationController
  
  # echocracy - The Benefits / The Actors
  def index
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Citizens
  def citizens
    respond_to do |format|
      format.html { render :partial => 'citizens', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Scientists
  def scientists
    respond_to do |format|
      format.html { render :partial => 'scientists', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Decision makers
  def decision_makers
    respond_to do |format|
      format.html { render :partial => 'decision_makers', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Organisations
  def organisations
    respond_to do |format|
      format.html { render :partial => 'organisations', :layout => 'static' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

end
