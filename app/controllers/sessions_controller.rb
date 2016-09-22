class SessionsController < ApplicationController

  def new_parent
      if teacher_logged_in?
         @center = Center.find(current_teacher.center_id)
      elsif center_logged_in?
         @center = current_center
      else
         flash[:info] = "Teacher or Admin login required."
         redirect_to root_path
      end
      @nav = "parent"
  end

  def create_parent
     # raise params.inspect
      parent = Parent.find_by(username: params[:session][:username])
      if parent && parent.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{parent.fname} #{parent.lname}."
         session[:parent_id] = parent.id
  	     redirect_to handoffs_new_path
      else
  		   flash[:danger] = 'Invalid username/password combination.'
  		   redirect_to parent_log_in_path
      end 
  end

  def destroy_parent
      log_out_parent
  	  flash[:success] = "Parent is logged off."
      redirect_to parent_log_in_path 
  end

  def new_teacher
      if parent_logged_in?
         log_out_parent
      end
      if center_logged_in?  
         log_out_center 
      end
      if teacher_logged_in? 
         log_out_teacher 
      end
      @nav = "root"
  end

  def create_teacher
     # raise params.inspect
      teacher = Teacher.find_by(username: params[:session][:username])
      if teacher && teacher.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{teacher.fname} #{teacher.lname}."
         session[:teacher_id] = teacher.id
         redirect_to parent_log_in_path
      else
         flash[:danger] = "Invalid username/password combination."
         redirect_to teacher_log_in_path
      end 
  end

  def destroy_teacher
  	  log_out_teacher
      flash[:success] = "Teacher is logged off."
      redirect_to "/"
  end

  def new_center
    # @nav = "b4_center_login"
  end

  def create_center
      center = Center.find_by(username: params[:session][:username])
      if center && center.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{center.name}."
         session[:center_id] = center.id
         redirect_to admin_path
      else
         flash[:danger] = "Invalid username/password combination."
         redirect_to center_log_in_path
      end 
  end

  def destroy_center
    	log_out_center
      flash[:success] = "Center is logged off."
      redirect_to "/" 
  end
end
