class SessionsController < ApplicationController
    def new_parent
    @parent = Parent.new
  end

  def create_parent
    @parent = Parent.find_by_email(params[:session][:email])
    if @parent && @parent.authenticate(params[:session][:password])
       flash[:success] = "Welcome #{@parent.name}!"
       log_in @parent 
	   redirect_to @parent
    else
		flash.now[:danger] = "Invalid email/password combination."
		redirect_to parent_log_in_path
    end 
  end

  def destroy_parent
  	session.delete(:parent_id)
    @current_parent = nil
	# session[:parent_id] = nil
	flash[:success] = "You are logged off."
    redirect_to "/" 
  end

  def new_teacher
    @teacher = Teacher.new
  end

  def create_teacher
    @teacher = Teacher.find_by_email(params[:session][:email])
    if @teacher && @teacher.authenticate(params[:session][:password])
      flash[:success] = "Welcome #{@teacher.name}!"
      log_in @teacher
      redirect_to @teacher
    else
      flash.now[:danger] = "Invalid email/password combination."
      redirect_to teacher_log_in_path
    end 
  end

  def destroy_teacher
  	session.delete(:teacher_id)
    @current_teacher = nil
    # session[:teacher_id] = nil
    flash[:success] = "You are logged off."
    redirect_to "/"
  end

  def new_center
    @center = Center.new
  end

  def create_center

    @center = Center.find_by_username(params[:session][:username])
    if @center && @center.authenticate(params[:session][:password])
      flash[:success] = "Welcome #{@center.name}!"
      log_in @center
      redirect_to @center
    else
      flash.now[:danger] = "Invalid username/password combination."
      redirect_to center_log_in_path
    end 
  end

  def destroy_center
  	session.delete(:center_id)
    @current_center = nil
    # session[:center_id] = nil
    flash[:success] = "You are logged off."
    redirect_to "/" 
  end
end
