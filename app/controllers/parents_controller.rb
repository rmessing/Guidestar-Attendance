class ParentsController < ApplicationController
  before_action :logged_in_center, except: [:show]

  # If superadmin (current_center.admin?) is logged in, center.id is in params, otherwise the current_center.id is used?
  # .where prevents user from seeing data belonging to centers other than his/her own.

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @parents = Parent.paginate(page: params[:page]).order("lname", "fname").where(:center_id => @center.id)  
      else
         @parents = Parent.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
      @parent = Parent.find(params[:id])
  end

  def new
      @parent = Parent.new
      if current_center.admin?
         @center = Center.find(params[:id])
      else
         @center = current_center
      end
  end

  def create
      @parent = Parent.new(parent_params)
      if @parent.save
         flash.now[:success] = "#{@parent.fname} #{@parent.lname} is registered."
         redirect_to @parent
      else
         @center = Center.find(@parent.center_id)
         render :new
      end
  end

  def edit
      @parent = Parent.find(params[:id])
      @center = Center.find(@parent.center_id)
  end

  def update
      @parent = Parent.find(params[:id])
      if @parent.update_attributes(parent_params)
         flash[:success] = "Parent #{@parent.fname} #{@parent.lname} is updated."
         redirect_to @parent
      else
         @center = Center.find(@parent.center_id)
         render :edit
      end
  end

  def destroy
      parent = Parent.find(params[:id])
      center = parent.center_id
      if parent.destroy
         flash[:success] = "Parent deleted."
      else
         flash[:danger] = "Parent deletion failed."
      end
      redirect_to parents_path(:id => center)
  end

  private
  def parent_params
      params.require(:parent).permit(:fname, :lname, :username, :email, :center_id, :password, :password_confirmation)
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
