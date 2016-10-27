class HandoffsController < ApplicationController
   # before_action :logged_in_parent, only: [:new, :create]

   # A handoff is an event where a parent drops-off or picks-up the child from daycare.

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
    params["handoffs"].each do |handoff|
      if handoff["checkbox"] != ""
        Handoff.create(handoff_params(handoff))
      end
    end
  end

  def destroy
  end


private

  def handoff_params(my_params)
    my_params.permit(:attend, :group_name, :child_id, :center_id, :escort_fname, :escort_lname, :child_fname, :child_mname, :child_lname)
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