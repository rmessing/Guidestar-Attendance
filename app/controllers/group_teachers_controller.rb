class GroupTeachersController < ApplicationController
  before_action :logged_in_center, except: [:new, :create, :edit, :update]
  before_action :correct_center, only: [:show]
  before_action :correct_center2, only: [:destroy]

  # If superadmin(current_center.admin?) is logged in, center.id is in params, otherwise the current_center.id is used?
  # .where prevents user from seeing data belonging to centers other than his/her own.
  #GroupTeachers is a join table for assigning/removing teachers to/from classes (groups).

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => @center.id)
      else
         @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => current_center.id)
      end
  end

  def show
      @groupteacher = GroupTeacher.new
      if current_center.admin?
         @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
      else
         @teachers = Teacher.order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def create 
      groupteacher = GroupTeacher.new(gt_params)
      if !groupteacher.save
         flash[:danger] = "Teacher is already assigned to this class."
      end
      redirect_to (:back)
  end

  def destroy
      teacher = Teacher.find(@groupteacher.teacher_id)
      group = Group.find(@groupteacher.group_id)
      if @groupteacher.destroy
         flash[:success] = "#{teacher.fname} #{teacher.lname} was delisted from #{group.name}."
      else
          flash[:danger] = "The request to reassign teacher #{teacher.fname} #{teacher.lname} failed.  Notify technical support." 
      end
          redirect_to (:back)
  end

  private
  def gt_params
    params.require(:group_teacher).permit(:teacher_id, :group_id, :center_id)
  end

    # Confirms a logged-in center.
  def logged_in_center
    unless center_logged_in?
      flash[:danger] = "Please log in."
      redirect_to center_log_in_path
    end
  end

  # Confirms only superadmin or current_center can create group-teacher relationships.
  def correct_center
      @group = Group.find(params[:id])
      @center = Center.find(@group.center_id)
      unless current_center.admin? || current_center?(@center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end

  # Confirms only superadmin or current_center can delete group-teacher relationships.
  def correct_center2
      @groupteacher = GroupTeacher.find(params[:id])
      center = Center.find(@groupteacher.center_id)
      unless current_center.admin? || current_center?(center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end
end
