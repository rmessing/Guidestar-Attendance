class LocationsController < ApplicationController
  before_action :logged_in_center, only: [:edit, :update]
  before_action :correct_center,   only: [:edit, :update]

  def index
  end

  def show
  end

  def new
      @location = Location.new
  end

  def edit
  end

  def update
      if location.update_attributes(location_params)
         flash[:success] = "Location #{group.name} is updated."
         redirect_to location
      else
         render 'edit'
      end
  end

  def create
      location = Location.new(location_params)
      if location.save
         flash[:success] = "Location #{location.name} is registered."
         redirect_to location
      else
         render 'new'
      end
  end

  def destroy
      Location.find(params[:id]).destroy
  end

  private
  def location_params
    params.require(:location).permit(:name,:center_id)
  end

      # Before filters

    # Confirms a logged-in center.
    def logged_in_center
      unless center_logged_in?
        flash[:danger] = "Please log in."
        redirect_to center_log_in_path
      end
    end

    # Confirms the correct user.
    def correct_center
      @center = Center.find(params[:id])
      redirect_to(root_url) unless current_center?(@center)
    end
end
