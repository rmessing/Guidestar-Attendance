class TeachersController < ApplicationController
  before_action :logged_in_center
  before_action :correct_center, only: [:show, :edit, :update, :destroy]

  # If superadmin is logged in (current_center.admin?), center.id is in params, 
  # otherwise the current_center.id is used? .where filters data to prevent user
  # from accessing data belonging to centers other than his/her own.
  
  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @teachers = Teacher.paginate(page: params[:page]).order("lname", "fname").where(:center_id => @center.id)  
      else
         @teachers = Teacher.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
  end

  def new
      @teacher = Teacher.new
      if current_center.admin?
         @center = Center.find(params[:id])
      else
         @center = current_center
      end
  end

  def create
      @teacher = Teacher.new(teacher_params)
      if @teacher.save
         flash[:success] = "#{@teacher.fname} #{@teacher.lname} is registered."
         redirect_to @teacher
      else
         @center = Center.find(@teacher.center_id)
         render :new 
      end
  end

  def edit
  end

  def update
      if @teacher.update_attributes(teacher_params)
         flash[:success] = "Teacher #{@teacher.fname} #{@teacher.lname} is updated."
         redirect_to @teacher
      else
         render :edit
      end
  end

  def destroy
      if @teacher.destroy
         flash[:success] = "Teacher deleted."
      else
         flash[:danger] = "Teacher deletion failed."
      end
      redirect_to teachers_path(:id => @center)
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

# Confirms only superadmin or current_center has access to @center data.
  def correct_center
      @teacher = Teacher.find(params[:id])
      @center = Center.find(@teacher.center_id)
      unless current_center.admin? || current_center?(@center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end
end
