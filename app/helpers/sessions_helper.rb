module SessionsHelper

  # Logs in the given user.
  def log_in(user)
      session[:user_id] = user.id
  end

   # Returns true if a center is logged in, false otherwise.
  def center_logged_in?
      !current_center.nil?
  end

   # Returns true if the given center is the current_center.
  def current_center?(center)
      center == current_center
  end

 # Returns the current logged-in users (if any):

  def current_parent
	  @current_parent ||= Parent.find_by(id: session[:parent_id])
  end

  def current_teacher
	  @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
  end

  def current_center
	  @current_center ||= Center.find_by(id: session[:center_id])
  end
end
