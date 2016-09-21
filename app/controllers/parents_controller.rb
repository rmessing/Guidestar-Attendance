class ParentsController < ApplicationController
  before_action :logged_in_center, only: [:new, :index, :create, :edit, :update, :destroy]

  def index
      if current_center.admin?
         @parents = Parent.paginate(page: params[:page]).order("center_id","lname", "fname")
      else
         @parents = Parent.paginate(page: params[:page]).order("lname", "fname").where(:center_id => current_center.id)
      end
  end

  def show
      @parent = Parent.find(params[:id])
  end

  def new
      @parent = Parent.new
  end

  def edit
      @parent = Parent.find(params[:id])
  end

  def create
     # raise params.inspect
   
      @parent = Parent.new(parent_params)
      if @parent.save
        flash[:success] = "Parent #{@parent.fname} #{@parent.lname} is registered"
        redirect_to @parent
      else
        render "new"
      end
  end

  def update
      @parent = Parent.find(params[:id])
      if @parent.update_attributes(parent_params)
         flash[:success] = "Parent #{@parent.fname} #{@parent.lname} is updated."
         redirect_to @parent
      else
         render 'edit'
      end
  end

  def destroy
      Parent.find(params[:id]).destroy
      flash[:success] = "Parent deleted."
      redirect_to (:back)
  end

  private
  def parent_params
    params.require(:parent).permit(:fname, :lname, :username, :email, :center_id, :password, :password_confirmation)
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
