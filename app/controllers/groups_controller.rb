class GroupsController < ApplicationController
  before_action :logged_in_center
  before_action :correct_center, only: [:show, :edit, :update, :destroy]

  # If superadmin is logged in (current_center.admin?), center.id is in params, 
  # otherwise the current_center.id is used? .where filters data to prevent user
  # from accessing data belonging to centers other than his/her own.

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => @center.id)  
      else
         @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => current_center.id)
      end
  end

  def show
  end

  def new
      @group = Group.new
      if current_center.admin?
         @center = Center.find(params[:id])
         @locations = Location.order("name").where(:center_id => @center.id)
         @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
      else
         @center = current_center
         @locations = Location.order("name").where(:center_id => current_center.id)
         @teachers = Teacher.order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def create
      @group = Group.new(group_params)
      if @group.save
         flash[:success] = "#{@group.name} is registered."
         redirect_to @group
      else
         @center = Center.find(@group.center_id)
         @locations = Location.order("name").where(:center_id => @center.id)
         @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
         render :new
      end
  end

  def edit
      @locations = Location.order("name").where(:center_id => @center.id)
      @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
  end

  def update
      if @group.update_attributes(group_params)
         flash[:success] = "#{@group.name} is updated."
         redirect_to @group
      else
         @locations = Location.order("name").where(:center_id => current_center.id)
         @teachers = Teacher.order("lname", "fname").where(:center_id => current_center.id)
         render :edit
      end
  end

  def destroy
      if @group.destroy
         flash[:success] = "Class deleted."
      else
         flash[:danger] = "Class deletion failed."
      end
      redirect_to groups_path(:id => @center)
  end

  private
  def group_params
      params.require(:group).permit(:name, :teacher_id, :location_id, :center_id)
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
      @group = Group.find(params[:id])
      @center = Center.find(@group.center_id)
      unless current_center.admin? || current_center?(@center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end
end
