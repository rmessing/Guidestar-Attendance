class FamiliesController < ApplicationController
  before_action :logged_in_center
 

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => @center.id)  
      else
         @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
      @family = Family.new
      @families = Family.all
      @child = Child.find(params[:id])
      @center = Center.find(@child.center_id)
      if current_center.admin?
         @parents = Parent.order("lname", "fname").where(:center_id => @center.id)
      else
         @parents = Parent.order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def new

  end

  def edit
  end

  def update
  end

  def create
      @family = Family.new(family_params)
      parent = Parent.find(@family.parent_id)
      if @family.save
         flash[:success] = "Adult #{parent.fname} #{parent.lname} is activated."
         redirect_to (:back)
      else
         flash[:info] = "Adult #{parent.fname} #{parent.lname} is already activated."
         redirect_to (:back)
      end
  end

  def destroy
      Family.find(params[:id]).destroy
      flash[:success] = "Adult de-activated."
      redirect_to (:back)
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
