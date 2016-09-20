class ChildrenController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]

  def index
      @children = Child.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
  end

  def show
      @child = Child.find(params[:id])
  end

  def new
      @child = Child.new
  end

  def edit
      @child = Child.find(params[:id])
  end

  def update
      @child = Child.find(params[:id])
      if @child.update_attributes(child_params)
         flash[:success] = "Child #{@child.fname} #{@child.mname} #{@child.lname} is updated."
         redirect_to @child
      else
         render 'edit'
      end
  end

  def create
      @child = Child.new(child_params)
      if @child.save
         flash.now[:success] = "Child #{@child.fname} #{@child.mname} #{@child.lname} is registered."
         redirect_to @child
      else 
         render "new"
      end
      
  end

  def destroy
      Child.find(params[:id]).destroy
      flash[:success] = "Child deleted."
      redirect_to (:back)
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
