class Users::ActivationsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
    
    respond_to do |format|
      format.html do
        render :template => 'users/activations/new', :layout => 'static'
      end
    end
  end

  def create
    @user = User.find(params[:id])

    raise Exception if @user.active?

    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      flash[:notice] = I18n.t('users.activation.messages.success')
      redirect_to welcome_path
    else
      flash[:error] = I18n.t('users.activation.messages.failed')
      render :template => 'users/activations/new', :layout => 'static'
    end
  end




end
