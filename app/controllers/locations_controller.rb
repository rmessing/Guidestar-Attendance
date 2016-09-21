class LocationsController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]

  def index
      @locations = Location.paginate(page: params[:page]).order("name").where(:center_id => current_center.id)
  end

  def show
      @location = Location.find(params[:id])
  end

  def new
      @location = Location.new
  end

  def edit
      @location = Location.find(params[:id])
  end

  def update
      @location = Location.find(params[:id])
      if @location.update_attributes(location_params)
         flash[:success] = "Location #{@location.name} is updated."
         redirect_to @location
      else
         render 'edit'
      end
  end

  def create
      @location = Location.new(location_params)
      if @location.save
         flash[:success] = "Location #{@location.name} is registered."
         redirect_to @location
      else
         render 'new'
      end
  end

  def destroy
      Location.find(params[:id]).destroy
      flash[:success] = "Location deleted."
      redirect_to (:back)
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

end
