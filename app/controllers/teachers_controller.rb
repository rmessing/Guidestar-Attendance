class TeachersController < ApplicationController
  def index
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
    @user = @teacher
  end

  def edit
  end

  def create 
    @teacher = Teacher.new(teacher_params)
    @user = @teacher
    if @teacher.save
      flash[:success] = "Welcome #{@teacher.fname} #{@teacher.lname}!"
      redirect_to @teacher
    else
      render "new"
    end

  end

  def update
  end

  def destroy
  end

  def teacher_params
      params.require(:teacher).permit(:fname, :lname, :username, :email, :center_id, :password, :password_confirmation, :reset_digest, :reset_sent_at)
  end
end
