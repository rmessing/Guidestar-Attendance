class FamiliesController < ApplicationController
  before_action :logged_in_center, except: [:show, :create, :update]

  # If superadmin is logged in, center.id is in params, otherwise the current_center.id is used?
  # .where prevents user from seeing data belonging to centers other than his/her own.
  # Families is a join table connecting children the adults authorized to escort them to and from the daycare center.
 
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
      family = Family.new(family_params)
      if !family.save
         flash[:info] = "Adult is already listed in child account."
      end
      redirect_to (:back)
  end

  def destroy
      family = Family.find(params[:id])
      parent = Parent.find(family.parent_id)
      child = Child.find(family.child_id)
      if family.destroy
          flash[:success] = "#{parent.fname} #{parent.lname} was delisted from #{child.fname} #{child.lname}'s account."
      else
          flash[:danger] = "The request to remove #{parent.fname} #{parent.lname} from #{child.fname} #{child.lname}'s account failed."
      end 
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
