class GroupsController < ApplicationController
  before_action :logged_in_center, only: [:edit, :update]
  before_action :correct_center,   only: [:edit, :update]

  def index
  end

  def show
      @group = Group.find(params[.id])
  end

  def new
      @group = Group.new
      @teachers = Teacher.order("lname", "fname")
      @locations = Location.order("name")
  end

  def edit
      @group = Group.find(params[.id])
  end

  def update
      group = Group.find(params[.id])
      if group.update_attributes(group_params)
         flash[:success] = "Class #{group.name} is updated."
         redirect_to @child
      else
         render 'edit'
      end
  end

  def create
      group = Group.new(group_params)
      if group.save
         flash.now[:success] = "Class #{group.name} is registered."
         redirect_to group
      else
         render "new"
      end
      
  end

  def destroy
      Group.find(params[.id]).destroy
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

    # Confirms the correct center.
    def correct_center
      @center = Center.find(params[:id])
      redirect_to(root_url) unless current_center?(@center)
    end
end
