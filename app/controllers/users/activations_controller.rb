class Users::ActivationsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end

  def create
    @user = User.find(params[:id])

    raise Exception if @user.active?

    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      flash[:notice] = I18n.t('users.activations.messages.success')
      redirect_to welcome_path
    else
      render :action => :new
    end
  end




end
