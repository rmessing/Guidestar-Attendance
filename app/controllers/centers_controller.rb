class CentersController < ApplicationController
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
  end

  def create
      @center = Center.new(center_params)
      if @center.save
         flash.now[:success] = "The new center #{@center.name} is now registered."
         redirect_to center
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
end
