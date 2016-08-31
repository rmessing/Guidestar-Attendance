class CentersController < ApplicationController
  def index
  end

  def show
    @center = Center.find(params[:id])
  end

  def new
    @center = Center.new
    @user = @center
  end

  def create
    @center = Center.new(center_params)
    @user = @center
    if @center.save
      flash[:success] = "Welcome #{@center.name}!"
      redirect_to @center
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def center_params
      params.require(:center).permit(:name, :username, :email, :password,
                                   :password_confirmation)
    end
end
