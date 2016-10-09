class GroupTeachersController < ApplicationController
  before_action :logged_in_center, except: [:edit, :update]

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
      @group = Group.find(params[:id])
      @center = Center.find(@group.center_id)
      if current_center.admin?
         @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
      else
         @teachers = Teacher.order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def new
  end

  def edit
  end

  def update
  end

  def create 
      groupteacher = GroupTeacher.new(gt_params)
      if !groupteacher.save
         flash[:danger] = "Teacher is already assigned to this class."
      end
      redirect_to (:back)
  end

  def destroy
      groupteacher = GroupTeacher.find(params[:id])
      teacher = Teacher.find(groupteacher.teacher_id)
      group = Group.find(groupteacher.group_id)
      if groupteacher.destroy
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
end
