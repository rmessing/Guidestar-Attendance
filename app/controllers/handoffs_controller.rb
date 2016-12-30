class HandoffsController < ApplicationController

  def index
    @search = Search.new
  
    if current_center.admin?
       @center = Center.find(session[:id])
    else
       @center = current_center
    end
    @groups = Group.all.where(:center_id => @center.id).uniq.pluck(:name)
    @locations = Location.all.where(:center_id => @center.id).uniq.pluck(:name)
    @handoffs = Handoff.order("created_at").where(:center_id => @center.id)
  end

  def new
    @handoff = Handoff.new
    @parent = current_parent
    @center = Center.find(@parent.center_id)
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
    if validate_check == 1 && params[:attend_type] == "arrive"
       flash[:info] = "#{validate_check} child was checked in."
    end
    if validate_check == 1 && params[:attend_type] == "depart"
       flash[:info] = "#{validate_check} child was checked out."
    end
    if validate_check > 1 && params[:attend_type] == "arrive"
       flash[:info] = "#{validate_check} children were checked in."
    end
    if validate_check > 1 && params[:attend_type] == "depart"
       flash[:info] = "#{validate_check} children were checked out."
    end
    redirect_to parent_log_in_path
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