class SessionsController < ApplicationController
  def new_parent
      @center = Center.find(current_teacher.center_id)
  end

  def create_parent
      @parent = Parent.find_by(username: params[:session][:username])
      if @parent && @parent.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{@parent.fname} #{@parent.lname}!"
         session[:parent_id] = @parent.id 
  	     redirect_to @parent
      else
  		   flash[:danger] = 'Invalid username/password combination.'
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
  end

  def create_teacher
      @teacher = Teacher.find_by(username: params[:session][:username])
      if @teacher && @teacher.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{@teacher.fname} #{@teacher.lname}!"
         session[:teacher_id] = @teacher.id
         redirect_to parent_log_in_path
      else
         flash[:danger] = "Invalid username/password combination."
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
  end

  def create_center
      @center = Center.find_by(username: params[:session][:username])
      if @center && @center.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{@center.name}!"
         session[:center_id] = @center.id
         redirect_to @center
      else
         flash[:danger] = "Invalid username/password combination."
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
