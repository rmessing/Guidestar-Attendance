class HandoffsController < ApplicationController
   # before_action :logged_in_parent, only: [:new, :create]
   # before_action :correct_parent,   only: [:new, :create]
  def index
  end

  def show
  end

  def new
    @nav = "parent"
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end

        # Before filters

    # Confirms a logged-in parent.
    # def logged_in_parent
    #   unless parent_logged_in?
    #     flash[:danger] = "Please log in."
    #     redirect_to parent_log_in_path
    #   end
    # end

    # Confirms the correct parent.
    # def correct_parent
    #   @parent = Parent.find(params[:id])
    #   redirect_to(root_url) unless current_parent?(@parent)
    # end