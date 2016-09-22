class GroupsController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]

  def index
      @groups = Group.paginate(page: params[:page]).order("name").where(:center_id => current_center.id)
  end

  def show
      @group = Group.find(params[:id])
  end

  def new
      @group = Group.new
      @locations = Location.order("name").where(:center_id => current_center.id)
      @teachers = Teacher.order("lname", "fname").where(:center_id => current_center.id)
  end

  def edit
      @group = Group.find(params[:id])
      @locations = Location.order("name")
  end

  def update
      @group = Group.find(params[:id])
      if @group.update_attributes(group_params)
         flash[:success] = "Class #{@group.name} is updated."
         redirect_to @group
      else
         render 'edit'
      end
  end

  def create
      @group = Group.new(group_params)
      if @group.save
         flash.now[:success] = "Class #{@group.name} is registered."
         redirect_to @group
      else
         render "new"
      end
      
  end

  def destroy
      Group.find(params[:id]).destroy
      flash[:success] = "Group deleted."
      redirect_to (:back)
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
