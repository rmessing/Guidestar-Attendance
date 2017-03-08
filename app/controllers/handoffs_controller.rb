class HandoffsController < ApplicationController
  before_action :logged_in_parent_or_teacher, only: [:new, :new_class]

  def index

    @search = Search.new

    if current_center.admin?
       @center = Center.find(session[:id])
    else
       @center = current_center
    end
    @groups = Group.all.where(:center_id => @center.id).uniq.pluck(:name)
    @locations = Location.all.where(:center_id => @center.id).uniq.pluck(:name)
    @handoffs = Handoff.order("created_at").where(:center_id => @center.id).where('created_at >= ?', 1.week.ago)
  end

  def new
    @handoff = Handoff.new
    @parent = current_parent
    @center = Center.find(@parent.center_id)
  end

  def new_class
    @handoff = Handoff.new
    @group = Group.find(params[:id])
    @center = Center.find(@group.center_id)
  end

  def pick_class
    @center = Center.find(current_teacher.center_id)
    @locations = Location.order("name").where(:center_id => @center.id)
  end

    # detecting no group select error before system abbend.
  def pick_presence
    if params[:group][:group_id] == ""
      flash[:info] = "First select your class."
      redirect_to (:back)
    else  
      redirect_to new_class_path(:id => params[:group][:group_id])
    end
  end

  def create
    validate_check = 0                 #used to determine if singular, plural or nil
    if params[:attend_type] == nil     #ensures user clicks the radio button
       flash[:danger] = "Select Drop-off or Pick-up."
       redirect_to (:back)
       return
    end 
    params[:handoff].each do |handoff| #performs save for each activated checkbox
      if handoff[:check] == "1"
         validate_check += 1
         @attendance = Handoff.new(attend: params[:attend_type], child_id: handoff[:child_id], child_fname: handoff[:child_fname], child_mname: handoff[:child_mname], child_lname: handoff[:child_lname], center_id: handoff[:center_id], escort_fname: handoff[:escort_fname], escort_lname: handoff[:escort_lname], location_name: handoff[:location_name], group_name: handoff[:group_name])
         @attendance.save
      end
    end
    if validate_check == 0
       flash[:danger] = "Select at least one child or logoff."
       redirect_to (:back)
       return
    end
    if validate_check == 1 && params[:attend_type] == "Arrive"
       flash[:info] = "#{validate_check} child was checked in."
    end
    if validate_check == 1 && params[:attend_type] == "Depart"
       flash[:info] = "#{validate_check} child was checked out."
    end
    if validate_check > 1 && params[:attend_type] == "Arrive"
       flash[:info] = "#{validate_check} children were checked in."
    end
    if validate_check > 1 && params[:attend_type] == "Depart"
       flash[:info] = "#{validate_check} children were checked out."
    end
    if parent_logged_in?
      redirect_to parent_log_in_path
    else
      redirect_to class_log_in_path
    end
  end

def delete_selected
  how_many = 0
  params[:ids].each do |id|
    handoff = Handoff.find(id)
    handoff.destroy
    how_many += 1
  end unless params[:ids].blank?
  if how_many == 1
    flash[:notice] = "#{how_many} attendance record was deleted successfully!"
  elsif how_many > 1 
    flash[:notice] = "#{how_many} attendance records were deleted successfully!"
  else
    flash[:alert] = "No attendance records were deleted."
  end
  redirect_to :back 
end

private
   # Before filters

  # Confirms a parent or teacher is logged in.
  def logged_in_parent_or_teacher
    unless parent_logged_in? || teacher_logged_in?
      flash[:danger] = "Please log in."
        redirect_to '/'
    end
  end

  # Confirms a logged-in center.
  def logged_in_center
      unless center_logged_in?
        flash[:danger] = "Please log in."
        redirect_to center_log_in_path
      end
  end

end