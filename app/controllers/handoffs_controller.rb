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
    params["handoff"].each do |handoff|
      if params[:handoff["check"]] != ""
      @handoff = Handoff.new
      @handoff.save
      end
    end
  end

  def destroy
  end


private

  def handoff_params
    params.require(:handoff).permit(:attend, :group_name, :child_id, :center_id, :escort_fname, :escort_lname, :child_fname, :child_mname, :child_lname)
  end
        # Before filters

  # Confirms a logged-in parent.
  def logged_in_parent
    unless parent_logged_in?
      flash[:danger] = "Please log in."
      redirect_to parent_log_in_path
    end
  end

end