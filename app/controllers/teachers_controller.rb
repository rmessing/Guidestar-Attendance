class TeachersController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]
  
  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @teachers = Teacher.paginate(page: params[:page]).order("lname", "fname").where(:center_id => @center.id)  
      else
         @teachers = Teacher.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
      @teacher = Teacher.find(params[:id])
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
         flash.now[:success] = "#{@teacher.fname} #{@teacher.lname} is registered."
         redirect_to @teacher
         return
      elsif current_center.admin?
         @center = Center.find(@teacher.center_id)
      else
         @center = current_center 
      end
      render :new 
  end

  def edit
      @teacher = Teacher.find(params[:id])
      if current_center.admin?
          @center = Center.find(@teacher.center_id)
      else 
          @center = current_center
      end
  end

  def update
      @teacher = Teacher.find(params[:id])
      if @teacher.update_attributes(teacher_params)
         flash[:success] = "Teacher #{@teacher.fname} #{@teacher.lname} is updated."
         redirect_to @teacher
         return
      elsif current_center.admin?
         @center = Center.find(@teacher.center_id)
      else
         @center = current_center
      end
      render :edit
  end

  def destroy
      teacher = Teacher.find(params[:id])
      center = teacher.center_id
      if teacher.destroy
         flash[:success] = "Teacher deleted."
      else
         flash[:danger] = "Teacher deletion failed."
      end
      redirect_to teachers_path(:id => center)
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
end
