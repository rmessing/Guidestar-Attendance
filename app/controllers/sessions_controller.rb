class SessionsController < ApplicationController
  def new_parent
      if current_teacher
         @center = Center.find(current_teacher.center_id)
      end
  end

  def create_parent
      user = Parent.find_by(username: params[:session][:username])
      if user && user.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{user.fname} #{user.lname}!"
         log_in user
  	     redirect_to user
      else
  		   flash[:danger] = 'Invalid username/password combination.'
  		   redirect_to parent_log_in_path
      end 
  end

  def destroy_parent
    	session.delete(:parent_id)
      @current_parent = nil
  	  flash[:success] = "You are logged off."
      redirect_to "/" 
  end

  def new_teacher
  end

  def create_teacher
      user = Teacher.find_by(username: params[:session][:username])
      if user && user.authenticate(params[:session][:password])
         log_in user
         redirect_to parent_log_in_path
      else
         flash[:danger] = "Invalid username/password combination."
         redirect_to teacher_log_in_path
      end 
  end

  def destroy_teacher
  	  session.delete(:teacher_id)
      @current_teacher = nil
      flash[:success] = "You are logged off."
      redirect_to "/"
  end

  def new_center
  end

  def create_center
      center = Center.find_by(username: params[:session][:username])
      if center && @center.authenticate(params[:session][:password])
         log_in user
         redirect_to center
      else
         flash[:danger] = "Invalid username/password combination."
         redirect_to center_log_in_path
      end 
  end

 private
  def destroy_center
    	session.delete(:center_id)
      @current_center = nil
      flash[:success] = "You are logged off."
      redirect_to "/" 
  end
end
