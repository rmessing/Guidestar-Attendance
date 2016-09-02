class PasswordResetsController < ApplicationController
  before_action :get_center,   only: [:edit, :update]
  before_action :valid_center, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @center = Center.find_by(email: params[:password_reset][:email].downcase)
    if @center
      @center.create_reset_digest
      @center.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to center_log_in_path
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
    @user = @center
  end

  def update
    if params[:center][:password].empty?                   
      @center.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @center.update_attributes(center_params)           
      session[:center_id] = center.id
      flash[:success] = "Password has been reset."
      redirect_to @center
    else
      render 'edit'                                      
    end
  end

  private

  def center_params
    params.require(:center).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_center
    @user = Center.find_by(email: params[:email])
  end

  # Confirms a valid center.
  def valid_center
    unless (@center && @center.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @center.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end