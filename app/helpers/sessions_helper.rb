module SessionsHelper

  # Logs in the given user.
  def log_in(user)
      session[:user_id] = user.id
  end

  # Logs out the current_center.
  def log_out_center
      session.delete(:center_id)
      @current_center = nil
  end

  # Logs out the current_parent.
  def log_out_parent
      session.delete(:parent_id)
      @current_parent = nil
  end

  # Logs out the current_teacher.
  def log_out_teacher
      session.delete(:teacher_id)
      @current_teacher = nil
  end

  # Returns true if a users are logged in, false otherwise.
  def center_logged_in?
      !current_center.nil?
  end

  def parent_logged_in?
      !current_parent.nil?
  end

  def teacher_logged_in?
      !current_teacher.nil?
  end

  # Returns true if the given center is the current_center.
  def current_center?(user)
      user == current_center
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
