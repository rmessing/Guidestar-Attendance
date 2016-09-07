class GroupsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @group = Group.new
    @teachers = Teacher.order("lname", "fname")
    @locations = Location.order("name")
    @user = @group
  end

  def edit
  end

  def update
  end

  def create
         @group = Group.new(group_params)
      if @group.save
         flash.now[:success] = "Class #{@group.name} is registered!"
         render "new"
      else
         flash.now[:danger] = "There was a problem registering a new class. Please try again."
         render "new"
      end
  end

  def destroy
  end

    def group_params
    params.require(:group).permit(:name, :teacher_id, :center_id)
  end
end
