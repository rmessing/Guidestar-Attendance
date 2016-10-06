class ChildrenController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => @center.id)  
      else
         @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
      @child = Child.find(params[:id])
  end

  def new
      @child = Child.new
      if current_center.admin?
         @center = Center.find(params[:id])
         @groups = Group.order("name").where(:center_id => @center.id)
      else
         @center = current_center
         @groups = Group.order("name").where(:center_id => current_center.id)
      end
  end

  def create
      @child = Child.new(child_params)
      if @child.save
         flash.now[:success] = "#{@child.fname} #{@child.mname} #{@child.lname} is registered."
         redirect_to @child
      else
         @center = Center.find(@child.center_id)
         @groups = Group.order("name").where(:center_id => @center.id)
         render :new
      end 
  end

  def edit
      @child = Child.find(params[:id])
      @center = Center.find(@child.center_id)
      @groups = Group.order("name").where(:center_id => @center.id)
  end

  def update
      @child = Child.find(params[:id])
      if @child.update_attributes(child_params)
         flash[:success] = "Child #{@child.fname} #{@child.mname} #{@child.lname} is updated."
         redirect_to @child
      else
         @center = Center.find(@child.center_id)
         @groups = Group.order("name").where(:center_id => @center.id)
         render :edit
      end
  end

  def destroy
      child = Child.find(params[:id])
      center = child.center_id
      if child.destroy
         flash[:success] = "Child deleted."
      else
         flash[:danger] = "Child deletion failed."
      end
      redirect_to children_path(:id => center)
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
end
