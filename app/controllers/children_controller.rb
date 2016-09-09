class ChildrenController < ApplicationController
  before_action :logged_in_center, only: [:edit, :update]
  before_action :correct_center,   only: [:edit, :update]

  def index
  end

  def show
  end

  def new
      @child = Child.new
  end

  def edit
  end

  def update
      if child.update_attributes(child_params)
         flash[:success] = "Child #{child.fname} #{child.mname} #{child.lname} is registered"
         redirect_to @child
      else
         render 'edit'
      end
  end

  def create
      if child.save
         flash.now[:success] = "Child #{child.fname} #{child.mname} #{child.lname} is registered!"
      else 
         render "new"
      end
      
  end

  def destroy
      Child.find(params[:id]).destroy
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

    # Confirms the correct center.
    def correct_center
      @center = Center.find(params[:id])
      redirect_to(root_url) unless current_center?(@center)
    end
end
