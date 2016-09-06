class ParentsPasswordResetsController < ApplicationController
  before_action :get_parent,   only: [:edit, :update]
  before_action :valid_parent, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @parent = Parent.find_by(email: params[:password_reset][:email].downcase)
    if @parent
      @parent.create_reset_digest
      @parent.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to parent_log_in_path
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:parent][:password].empty?                   
      @parent.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @parent.update_attributes(parent_params)           
      session[:parent_id] = @parent.id
      @parent.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @parent
    else
      render 'edit'                                      
    end
  end

  private

  def parent_params
    params.require(:parent).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_parent
    @parent = Parent.find_by(email: params[:email])
    @user = @parent
  end

  # Confirms a valid parent.
  def valid_parent
    unless (@parent && @parent.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @parent.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_parents_password_reset_url
    end
  end
end
