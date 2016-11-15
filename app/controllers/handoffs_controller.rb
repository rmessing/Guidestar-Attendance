class HandoffsController < ApplicationController
  
   # This controller is under development.

  
  def index
  end

  def show
  end

  def new
    @handoff = Handoff.new
    @parent = current_parent
    @center = Center.find(@parent.center_id)
  end

  def edit
  end

  def update
  end

  def create
    validate_check = 0
    if params[:attend_type] == nil
       flash[:danger] = "Select Drop-off or Pick-up."
       redirect_to (:back)
       return
    end 
    params[:handoff].each do |handoff|     
      if handoff[:check] == "1"
         validate_check += 1
         @attendance = Handoff.new(attend: params[:attend_type], child_id: handoff[:child_id], child_fname: handoff[:child_fname], child_mname: handoff[:child_mname], child_lname: handoff[:child_lname], center_id: handoff[:center_id], escort_fname: handoff[:escort_fname], escort_lname: handoff[:escort_lname], group_name: handoff[:group_name])
         @attendance.save
      end
    end
    if validate_check == 0
       flash[:danger] = "Select at least one child or logoff."
       redirect_to (:back)
       return
    elsif validate_check == 1
       flash[:info] = "#{validate_check} child was checked in."
    else
       flash[:info] = "#{validate_check} children were checked in."
    end
    redirect_to parent_log_in_path
  end

  def destroy
  end


private
        # Before filters

  # Confirms a logged-in parent.
  def logged_in_parent
    unless parent_logged_in?
      flash[:danger] = "Please log in."
      redirect_to parent_log_in_path
    end
  end

end