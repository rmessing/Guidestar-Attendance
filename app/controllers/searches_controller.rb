class SearchesController < ApplicationController

  def show

  	@search = Search.find(params[:id])
    Search.last.destroy
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

  