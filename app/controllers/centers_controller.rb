class CentersController < ApplicationController
  before_action :superadmin, except: [:admin, :show]

  def index
      @centers = Center.paginate(page: params[:page]).order("name")
  end

  def show
      @center = Center.find(params[:id])

      # Confirms only superadmin may view the superadmin profile.
      if !current_center.admin? && @center.admin?
         flash[:danger] = "Not authorized to view profile."
         redirect_to center_log_in_path
      end
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

  # Confirms only superadmin has access to centers.
  def superadmin
      if !center_logged_in?
          flash[:danger] = "Access to previous page was denied."
          redirect_to '/' 
      elsif !current_center.admin?
          flash[:danger] = "Access to previous page was denied."
          redirect_to admin_path
      end
  end
end
