class SessionsController < ApplicationController
  

  def new_parent

    # Prevents login unless teacher or center is already logged in. Requires parent to login while on center premises, to prevent entering fraudulent attendance records remotely.
      if teacher_logged_in?
         @center = Center.find(current_teacher.center_id)
      elsif center_logged_in?
         @center = current_center
      else
         flash[:info] = "Teacher or Administrator login required."
         redirect_to root_path
      end
      @nav = "parent"
  end

  def create_parent
      parent = Parent.find_by(username: params[:session][:username])
      if parent && parent.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{parent.fname} #{parent.lname}."
         session[:parent_id] = parent.id
  	     redirect_to new_handoff_path
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
      @nav = "teacher"
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
    @nav = "admin"
  end

  def create_center
      center = Center.find_by(username: params[:session][:username])
      if center && center.authenticate(params[:session][:password])
         flash[:success] = "Welcome #{center.name}."
         session[:center_id] = center.id
      else 
         flash.now[:danger] = "Invalid username/password combination."
         render 'new_center'
         return
      end
      if center.admin? 
         redirect_to superadmin_path
      else
         redirect_to admin_path
      end 
  end

  def destroy_center
    	log_out_center
      flash[:success] = "Administrator is logged off."
      redirect_to "/"
  end
end
