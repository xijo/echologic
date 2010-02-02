class Users::ConcernmentsController < ApplicationController

  before_filter :require_user

  helper :profile
  
  access_control do
    allow logged_in
  end

  # Generate auto completion based on tag values in the database. Load only 5
  # suggestions a time.
  auto_complete_for :tag, :value, :limit => 5

  # Create a new concernment connection for a user and a given topic with the
  # sort of concernment specified.
  #
  # Method:   POST
  # Params:   tag_value: string, user_id: integer, sort: integer
  # Response: JS
  #
  def create
    @concernments = []
    for value in params[:tag][:value].split(',') do
      tag = Tag.find_or_create_by_value(value.strip)
      @concernments << Concernment.new(:user_id => current_user.id, :tag_id => tag.id, :sort => params[:sort])
    end
    @concernments.delete_if { |c| !c.save }
    respond_to do |format|
      format.js
    end
  end

  # Remove a specified concernment.
  #
  # Method:   DELETE
  # Params:   id:integer
  # Response: JS
  #
  def destroy
    @concernment = Concernment.find(params[:id])
    @concernment.destroy

    respond_to do |format|
      format.js do
        # sorry, but this was crap. you can't add additional js actions like this...
        # either use a rjs, a js, or a render :update block
        # remove_container("concernment_#{params[:id]}")
        render :template => 'users/profile/remove_object', :locals => { :object => @concernment }
      end
    end
  end
end
