class LocationsController < ApplicationController
  before_action :logged_in_center
  before_action :correct_center, only: [:show, :edit, :update, :destroy]

  # If superadmin is logged in (current_center.admin?), center.id is in params, 
  # otherwise the current_center.id is used? .where filters data to prevent user
  # from accessing data belonging to centers other than his/her own.

  def index
      if current_center.admin?
         @center = Center.find(params[:id])
         @locations = Location.paginate(page: params[:page]).order("name").where(:center_id => @center.id)  
      else
         @locations = Location.paginate(page: params[:page]).order("name").where(:center_id => current_center.id)
      end
  end

  def show
  end

  def new
      @location = Location.new
      if current_center.admin?
         @center = Center.find(params[:id])
      else
         @center = current_center
      end
  end

  def create
      @location = Location.new(location_params)
      if @location.save
         flash[:success] = "#{@location.name} is registered."
         redirect_to @location
      else
         @center = Center.find(@location.center_id)
         render :new
      end
  end

  def edit
  end

  def update
      if @location.update_attributes(location_params)
         flash[:success] = "Location #{@location.name} is updated."
         redirect_to @location
      else
         render :edit
      end
  end

  def destroy
      if @location.destroy
         flash[:success] = "Location deleted."
      else
         flash[:danger] = "Location deletion failed."
      end
      redirect_to locations_path(:id => @center)
  end

  private

  def location_params
      params.require(:location).permit(:name, :center_id)
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
      @location = Location.find(params[:id])
      @center = Center.find(@location.center_id)
      unless current_center.admin? || current_center?(@center)
        flash[:danger] = "Access denied."
        redirect_to '/'
      end
  end
end
