class Users::ConcernmentsController < ApplicationController

  before_filter :require_user
  
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
    tag = Tag.find_or_create_by_value(params[:tag][:value])
    @concernment = Concernment.new(:user_id => current_user.id, :tag_id => tag.id, :sort => params[:sort])

    respond_to do |format|
      format.js do
        if @concernment.save
          format.js
        else
          show_error_messages(@concernment)
        end
      end
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
        remove_container("concernment_#{params[:id]}")
      end
    end
  end
end
