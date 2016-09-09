class TeachersController < ApplicationController
  before_action :logged_in_center, only: [:edit, :update]
  before_action :correct_center,   only: [:edit, :update]

  def index
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def edit
  end

  def create 
    teacher = Teacher.new(teacher_params)
    if teacher.save
       flash[:success] = "Welcome #{teacher.fname} #{teacher.lname}!"
       redirect_to teacher
    else
      render "new"
    end

  end

  def update
      if teacher.update_attributes(teacher_params)
         flash[:success] = "Teacher #{teacher.fname} #{teacher.lname} is updated."
         redirect_to teacjer
      else
         render 'edit'
      end
  end

  def destroy
      @teacher = Teacher.find(params[:id])
  end

  private
  def teacher_params
      params.require(:teacher).permit(:fname, :lname, :username, :email, :center_id, :password, :password_confirmation)
  end

      # Before filters

    # Confirms a logged-in center.
    def logged_in_center
      unless center_logged_in?
        flash[:danger] = "Please log in."
        redirect_to center_log_in_path
      end
    end

    # Confirms the correct user.
    def correct_center
      @center = Center.find(params[:id])
      redirect_to(root_url) unless current_center?(@center)
    end
end
