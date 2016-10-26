class HandoffsController < ApplicationController
   # before_action :logged_in_parent, only: [:new, :create]

   # A handoff is an event where a parent drops-off or picks-up the child from daycare.

  def index
  end

  def show
  end

  def new
    @handoff = Handoff.new
    @parent = Parent.find(params[:id])
    @center = Center.find(@parent.center_id)
  end

  def edit
  end

  def update
  end

  def create
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