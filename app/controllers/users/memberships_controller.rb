class Users::MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.xml
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.xml
  def show
    @membership = Membership.find(params[:id])

    render :update do |page|
      page.replace_html "membership_#{@membership.id}", :partial => 'membership', :locals => { :membership => @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.xml
  def new
    @membership = Membership.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
    
    render :update do |page|
      page.replace_html "membership_#{@membership.id}", :partial => 'edit'
    end
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    @membership = Membership.new(params[:membership])

    render :update do |page|
      if @membership.save
        page.insert_html :bottom, 'membershipList', :partial => 'membership', :locals => { :membership => @membership }
        page['new_membership_form'].reset
      else
        show_javascript_errors(@membership, page)
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.xml
  def update
    @membership = Membership.find(params[:id])

    render :update do |page|
      if @membership.update_attributes(params[:membership])
        page.replace_html "membership_#{@membership.id}", :partial => 'membership', :locals => { :membership => @membership }
      else
        show_javascript_errors(@membership, page)
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.xml
  def destroy
    @membership = Membership.find(params[:id])
    id = @membership.id
    @membership.destroy
    
    render :update do |page|
      page.remove "membership_#{@membership.id}"
    end
  end
end
