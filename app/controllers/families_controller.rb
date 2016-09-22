class FamiliesController < ApplicationController
  before_action :logged_in_center
 

  def index
    @children = Child.order("lname", "fname").where(:center_id => current_center.id)
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
         flash[:notice] = "New child-adult registration succeeded."
         redirect_to (:back)
      else
         flash[:alert] = "New child-adult registration failed. Please try again."
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

end
