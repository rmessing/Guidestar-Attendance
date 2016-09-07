class ChildrenController < ApplicationController
  def index
  end

  def show
  end

  def new
    @child = Child.new
    @user = @child
  end

  def edit
  end

  def update
  end

  def create
         @child = Child.new(child_params)
      if @child.save
         flash.now[:success] = "Child #{@child.fname} #{@child.mname} #{@child.lname} is registered!"
      else
         flash.now[:danger] = "The child is not registered. First & last names are required."
      end
      render "new"
  end

  def destroy
  end

    private

   def child_params
    params.require(:child).permit(:fname, :mname, :lname, :center_id, :group_id, :birth_date)
   end
end
