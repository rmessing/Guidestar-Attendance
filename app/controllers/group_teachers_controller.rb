class GroupTeachersController < ApplicationController
  before_action :logged_in_center
  # before_action :correct_center

  def index
  end

  def show
  end

  def new
      @group_teachers = Group_teacher.order("name")
  end

  def edit
  end

  def update
  end

  def create
      @group_teacher = Group_teacher.new(gt_params)
      if @group_teacher.save
         flash[:notice] = "#{teacher_full_name} is assigned to class: #{@group.name}"
         redirect_to group_teachers_path
      else
         flash[:alert] = "The teacher assignment failed. Please try again."
         redirect_to (:back)
      end
  end

  def destroy
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
