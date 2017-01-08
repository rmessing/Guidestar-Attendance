class ChildrenController < ApplicationController
  before_action :logged_in_center
  before_action :correct_center, only: [:show, :edit, :update, :destroy]

  # If superadmin is logged in (current_center.admin?), center.id is in params, 
  # otherwise the current_center.id is used? .where filters data to prevent user
  # from accessing data belonging to centers other than his/her own.

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => @center.id)  
      else
         @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
  end

  def new
      @child = Child.new
      if current_center.admin?
         @center = Center.find(params[:id])
         @groups = Group.order("name").where(:center_id => @center.id)
         @locations = Location.order("name").where(:center_id => @center.id)
      else
         @center = current_center
         @groups = Group.order("name").where(:center_id => current_center.id)
         @locations = Location.order("name").where(:center_id => current_center.id)
      end
      if @center.children.length == 100
         flash.now[:danger] = "You've reached your limit of 100 registered children."
         redirect_to (:back)
      elsif @center.children.length > 94
         flash.now[:warning] = "WARNING: #{@center.children.length} children are registered - the limit is 100 registered children."
      end
  end

  def create
      @child = Child.new(child_params)
      if @child.save
         flash[:success] = "#{@child.fname} #{@child.mname} #{@child.lname} is registered."
         redirect_to @child
      else
         @center = Center.find(@child.center_id)
         @groups = Group.order("name").where(:center_id => @center.id)
         render :new
      end 
  end

  def edit
      @groups = Group.order("name").where(:center_id => @center.id)
  end

  def update
      if @child.update_attributes(child_params)
         flash[:success] = "Child #{@child.fname} #{@child.mname} #{@child.lname} is updated."
         redirect_to @child
      else
         @groups = Group.order("name").where(:center_id => @center.id)
         render :edit
      end
  end

  def destroy
      if @child.destroy
         flash[:success] = "Child deleted."
      else
         flash[:danger] = "Child deletion failed."
      end
      redirect_to children_path(:id => @center)
  end

  private
  def child_params
      params.require(:child).permit(:fname, :mname, :lname, :center_id, :group_id, :birth_date)
  end

# Before filters

# Confirms a logged-in center.
  def logged_in_center
      unless center_logged_in?
        flash[:danger] = "Please log in."
        redirect_to center_log_in_path
      end
  end

# Confirms only superadmin or current_center has access to @center data.
  def correct_center
      @child = Child.find(params[:id])
      @center = Center.find(@child.center_id)
      unless current_center.admin? || current_center?(@center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end

end
