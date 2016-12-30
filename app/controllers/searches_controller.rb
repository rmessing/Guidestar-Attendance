class SearchesController < ApplicationController

  def new
  	@search = Search.new
    
      if current_center.admin?
         @center = Center.find(params[:id])
         @groups = Group.all.where(:center_id => @center.id).uniq.pluck(:name)
         @locations = Location.all.where(:center_id => @center.id).uniq.pluck(:name)
      else
         @center = current_center
         @groups = Group.all.where(:center_id => @center.id).uniq.pluck(:name)
         @locations = Location.all.where(:center_id => @center.id).uniq.pluck(:name)
      end
  end

  def show
  	@search = Search.find(params[:id])
    if  current_center.admin?
        @center = Center.find(session[:id])
    else
        @center = current_center
    end
  end

  def create
  	@search = Search.create(search_params)
    redirect_to @search
  end

  private

  def search_params
  	  params.require(:search).permit(:class_name, :child_name, :adult_name, :location_name)
  end

end

  