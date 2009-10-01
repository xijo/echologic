class Users::ConcernmentsController < ApplicationController
  # GET /concernments
  # GET /concernments.xml
  def index
    @concernments = Concernment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @concernments }
    end
  end

  # GET /concernments/1
  # GET /concernments/1.xml
  def show
    @concernment = Concernment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @concernment }
    end
  end

  # POST /concernments
  # POST /concernments.xml
  def create
    tag = Tag.find_or_create_by_value(params[:value])
    @concernment = Concernment.new(:user_id => params[:user_id], :tag_id => tag.id, :sort => params[:sort])

    respond_to do |format|
      
      if @concernment.save
        format.js do
          render :update do |page|
            page.insert_html :bottom, "concernments_#{params[:sort]}", :partial => 'users/concernments/concernment', :locals => { :concernment => @concernment }
            page["new_concernment_#{params[:sort]}"].reset
          end
        end
      else
        format.html { render :text => 'failed' }
      end
#        flash[:notice] = 'Concernment was successfully created.'
#        format.html { redirect_to(@concernment) }
#        format.xml  { render :xml => @concernment, :status => :created, :location => @concernment }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @concernment.errors, :status => :unprocessable_entity }
#      end
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
