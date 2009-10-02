class Users::ConcernmentsController < ApplicationController

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
    @concernment = Concernment.new(:user_id => params[:user_id], :tag_id => tag.id, :sort => params[:sort])

    respond_to do |format|
      
      if @concernment.save
        format.js
      else
        format.js { render :template => 'users/concernments/failed' }
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
      format.js
    end
  end
end
