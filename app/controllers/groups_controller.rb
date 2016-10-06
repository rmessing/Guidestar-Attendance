class GroupsController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => @center.id)  
      else
         @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => current_center.id)
      end
  end

  def show
      @group = Group.find(params[:id])
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
         flash.now[:success] = "#{@group.name} is registered."
         redirect_to @group
      else
         @center = Center.find(@group.center_id)
         @locations = Location.order("name").where(:center_id => @center.id)
         @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
         render :new
      end
  end

  def edit
      @group = Group.find(params[:id])
      @center = Center.find(@group.center_id)
      @locations = Location.order("name").where(:center_id => @center.id)
      @teachers = Teacher.order("lname", "fname").where(:center_id => @center.id)
  end

  def update
      @group = Group.find(params[:id])
      if @group.update_attributes(group_params)
         flash[:success] = "#{@group.name} is updated."
         redirect_to @group
      else
         @center = Center.find(@group.center_id)
         @locations = Location.order("name").where(:center_id => current_center.id)
         @teachers = Teacher.order("lname", "fname").where(:center_id => current_center.id)
         render :edit
      end
  end

  def destroy
      group = Group.find(params[:id])
      center = group.center_id
      if group.destroy
         flash[:success] = "Class deleted."
      else
         flash[:danger] = "Class deletion failed."
      end
      redirect_to groups_path(:id => center)
  end

  private
  def group_params
      params.require(:group).permit(:name, :teacher_id, :center_id)
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
