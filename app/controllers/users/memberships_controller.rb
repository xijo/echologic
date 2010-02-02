class Users::MembershipsController < ApplicationController

  before_filter :require_user
  
  helper :profile
  
  access_control do
    allow logged_in
  end

  # Shows the membership identified through params[:id]
  # method: GET
  def show
    @membership = Membership.find(params[:id])
    respond_to do |format|
      format.js do
        replace_content(dom_id(@membership), :partial => 'membership')
      end
    end
  end

  # Render the new membership template. Currently unused.
  # method: GET
  def new
    @membership = Membership.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # Render the edit membership template. Currently only respond to JS.
  # method: GET
  def edit
    @membership = Membership.find(params[:id])
    
    respond_to do |format|
      format.js do
        replace_content(dom_id(@membership), :partial => 'edit')
      end
    end
  end

  # Create a new membership with the given params. Show error messages
  # through javascript if something fails.
  # method: POST
  def create
    @membership = Membership.new(params[:membership])

    respond_to do |format|
      format.js do
        if @membership.save
          render :template => 'users/profile/create_object', :locals => { :object => @membership }          
        else
          show_error_messages(@membership)
        end
      end
    end
  end

  # Update the membership attributes.
  # method: PUT
  def update
    @membership = Membership.find(params[:id])
    
    respond_to do |format|
      format.js do
        if @membership.update_attributes(params[:membership])
          replace_content(dom_id(@membership), :partial => 'membership')
        else
          show_error_messages(@membership)
        end
      end
    end
  end

  # Destroy the membership specified through params[:id]
  # method: DELETE
  def destroy
    @membership = Membership.find(params[:id])
    id = @membership.id
    @membership.destroy
    
    respond_to do |format|
      format.js do
        # sorry, but this was crap. you can't add additional js actions like this...
        # either use a rjs, a js, or a render :update block
        ## remove_container("membership_#{@membership.id}")
        render :template => 'users/profile/remove_object', :locals => { :object => @membership }     
      end
    end
  end
end
