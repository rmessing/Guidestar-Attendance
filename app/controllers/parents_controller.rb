class ParentsController < ApplicationController
  def index
  end

  def show
    @parent = Parent.find(params[:id])
  end

  def new
    @parent = Parent.new
    @user = @parent
  end

  def edit
  end

  def create
    @parent = Parent.new(parent_params)
    @user = @parent
    if @parent.save
      flash[:success] = "Welcome #{@parent.fname} #{@parent.lname}!"
      redirect_to @parent
    else
      render "new"
    end
  end

  def update
  end

  def destroy
  end

  private
    def parent_params
      params.require(:parent).permit(:fname, :lname, :username, :email, :center_id, :password, :password_confirmation)
    end
end
