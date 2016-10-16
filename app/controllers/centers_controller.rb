class CentersController < ApplicationController
  before_action :superadmin, except: [:admin, :show]
  before_action :logged_in_center, only: [:admin, :show]
  before_action :correct_center, only: [:show]

  def index
      @centers = Center.paginate(page: params[:page]).order("name")
  end

  def show
  end

  def new
      @center = Center.new
  end

  def admin
  end

  def superadmin
  end

  def create
      @center = Center.new(center_params)
      if @center.save
         flash[:success] = "#{@center.name} is registered."
         redirect_to @center
      else
         render 'new'
      end
  end

  def edit
      @center = Center.find(params[:id])
  end

  def update
      @center = Center.find(params[:id])
      if @center.update_attributes(center_params)
         flash[:success] = "#{@center.name} has been updated."
         redirect_to @center
      else
         render 'edit'
      end
  end

  def destroy
      if Center.find(params[:id]).destroy
         flash[:success] = "Client deleted successfully."
      else
         flash[:danger] = "Client deletion failed." 
      end
      redirect_to superadmin_path
  end

  private
  def center_params
      params.require(:center).permit(:name, :username, :dirfname, :dirlname, :email, :password,
                                 :password_confirmation)
  end

  # Before filters

  # Confirms only superadmin can create/update/delete center data.
  def superadmin
      if !center_logged_in?
          flash[:danger] = "Access is denied."
          redirect_to '/' 
      elsif !current_center.admin?
          flash[:danger] = "Access is denied."
          redirect_to admin_path
      end
  end

  # Confirms a logged-in center.
  def logged_in_center
      unless center_logged_in?
        flash[:danger] = "Please log in."
        redirect_to center_log_in_path
      end
  end

  # Confirms only current_center or superadmin can see @center profile.
  def correct_center
      @center = Center.find(params[:id])
      unless current_center.admin? || current_center?(@center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end
end
