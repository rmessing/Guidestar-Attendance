class SearchesController < ApplicationController

  def show
  
  	 @search = Search.find(params[:id])

    if  current_center.admin?
        @center = Center.find(session[:id])
    else
        @center = current_center
    end
    @locations = Location.all.where(:center_id => @center.id)
    @handoffs = @search.search_handoffs.where(:center_id => @center.id)

    # Filter attendance search by date range
    @handoffs = @handoffs.where('created_at > ? AND created_at < ?', @search.date_from.beginning_of_day, @search.date_to.end_of_day) if @search.date_from.present? && @search.date_to.present?
  end

  def create
    if Search.last
      Search.last.destroy
    end
  	@search = Search.create(search_params)
    redirect_to @search
  end

  private

  def search_params
  	  params.require(:search).permit(:class_name, :child_name, :adult_name, :location_name, :date_from, :date_to)
  end

end

  