class Users::ConcernmentsController < ApplicationController

  auto_complete_for :tag, :value, :limit => 5

  # POST /concernments
  # POST /concernments.xml
  def create
    tag = Tag.find_or_create_by_value(params[:tag][:value])
    @concernment = Concernment.new(:user_id => params[:user_id], :tag_id => tag.id, :sort => params[:sort])

    respond_to do |format|
      
      if @concernment.save
#        format.js do
#          render :update do |page|
#            page.insert_html :bottom, "concernments_#{params[:sort]}", :partial => 'users/concernments/concernment', :locals => { :concernment => @concernment }
#            page["new_concernment_#{params[:sort]}"].reset
#          end
#        end
        format.js
      else
        format.html { render :text => 'failed' }
      end
    end
  end

  # DELETE /concernments/1
  # DELETE /concernments/1.xml
  def destroy
    @concernment = Concernment.find(params[:id])
    @concernment.destroy

    respond_to do |format|
      format.js do
        render :update do |page|
          page.remove "concernment_#{params[:id]}"
        end
      end
    end
  end
end
