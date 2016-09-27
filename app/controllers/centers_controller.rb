class CentersController < ApplicationController
  before_action :superadmin, only: [:new, :index, :edit, :update, :create, :destroy]

  def index
      @centers = Center.paginate(page: params[:page]).order("name")
  end

  def show
      @center = Center.find(params[:id])
  end

  def new
      @center = Center.new
  end

  def admin
      @nav = "center"
  end

  def superadmin
  end

  def create
      @center = Center.new(center_params)
      if @center.save
         flash.now[:success] = "The new center #{@center.name} is now registered."
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
       flash[:success] = "Center #{@center.name} has been updated."
       redirect_to @center
    else
       render 'edit'
    end
  end

  def destroy
      Center.find(params[:id]).destroy
      flash[:success] = "Center deleted."
      redirect_to (:back)
  end

  private
  def center_params
      params.require(:center).permit(:name, :username, :email, :password,
                                 :password_confirmation)
  end

        # Before filters

    # Confirms a logged-in center.
    def logged_in_center
      unless center_logged_in?
        flash[:danger] = "Please log in."
        redirect_to center_log_in_path
      end
    end

    # Confirms an admin user.
  def superadmin
      if !center_logged_in?
          flash[:danger] = "Access to previous page was declined."
          redirect_to(root_url) 
      elsif !current_center.admin?
          redirect_to(root_url)
      end
  end

end
