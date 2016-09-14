class FamiliesController < ApplicationController
  before_action :logged_in_center
  # before_action :correct_center

  def index
    @children = Child.order("lname", "fname")
  end

  def show
  end

  def new
      @family = Family.new
  end

  def edit
  end

  def update
  end

  def create
      @family = Family.new(family_params)
      if @family.save
        flash[:notice] = "Adult and child are now connected!"
        redirect_to families_path
      else
        flash[:alert] = "The adult-child connection failed. Please try again."
        redirect_to (:back)
      end
  end

  def destroy
  end

  private
  def family_params
    params.require(:family).permit(:child_id, :parent_id, :center_id)
  end

      # Before filters

  # Confirms a logged-in center.
  def logged_in_center
    unless center_logged_in?
      flash[:danger] = "Please log in."
      redirect_to center_log_in_path
    end
  end

    # # Confirms the correct center.
    # def correct_center
    #   @center = Center.find(params[:id])
    #   redirect_to(root_url) unless current_center?(@center)
    # end
end
