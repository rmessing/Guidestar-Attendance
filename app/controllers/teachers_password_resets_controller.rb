class TeachersPasswordResetsController < ApplicationController
  before_action :get_teacher,   only: [:edit, :update]
  before_action :valid_teacher, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @teacher = Teacher.find_by(email: params[:password_reset][:email].downcase)
    if @teacher
      @teacher.create_reset_digest
      @teacher.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to teacher_log_in_path
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:teacher][:password].empty?                   
      @teacher.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @teacher.update_attributes(teacher_params)           
      session[:teacher_id] = @teacher.id
      @teacher.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to parent_log_in_path
    else
      render 'edit'                                      
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_teacher
    @teacher = Teacher.find_by(email: params[:email])
    @user = @teacher
  end

  # Confirms a valid teacher.
  def valid_teacher
    unless (@teacher && @teacher.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @teacher.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_teachers_password_reset_url
    end
  end
end
