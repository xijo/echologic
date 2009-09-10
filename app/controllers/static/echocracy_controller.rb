class Static::EchocracyController < ApplicationController
  
  # echocracy - The Benefits / The Actors
  def index
    respond_to do |format|
      format.html { render :partial => 'index', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Citizens
  def citizens
    respond_to do |format|
      format.html { render :partial => 'citizens', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Scientists
  def scientists
    respond_to do |format|
      format.html { render :partial => 'scientists', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Decision makers
  def decision_makers
    respond_to do |format|
      format.html { render :partial => 'decision_makers', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # echocracy - Organisations
  def organisations
    respond_to do |format|
      format.html { render :partial => 'organisations', :layout => 'application' }
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

end
