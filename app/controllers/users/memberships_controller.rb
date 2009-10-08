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

    respond_to do |format|
      format.html # show.html.erb
      format.js do
        render :update do |page|
          page.replace_html "membership_#{@membership.id}", :partial => 'membership', :locals => { :membership => @membership }
        end
      end
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
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html "membership_#{@membership.id}", :partial => 'edit'
        end
      end
    end
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    @membership = Membership.new(params[:membership])

    respond_to do |format|
      if @membership.save
        flash[:notice] = 'Membership was successfully created.'
        format.html { redirect_to(@membership) }
        format.js   {
          render :update do |page|
            page.insert_html :bottom, 'membershipList', :partial => 'membership', :locals => { :membership => @membership }
          end
        }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.xml
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        flash[:notice] = 'Membership was successfully updated.'
        format.html { redirect_to(@membership) }
        format.js do
          render :update do |page|
            page.replace_html "membership_#{@membership.id}", :partial => 'membership', :locals => { :membership => @membership }
          end
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.xml
  def destroy
    @membership = Membership.find(params[:id])
    id = @membership.id
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to(memberships_url) }
      format.js do
        render :update do |page|
          page.remove "membership_#{@membership.id}"
        end
      end
    end
  end
end
