class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  helper_method :current_parent
  def current_parent
	  @current_parent ||= Parent.find_by(id: session[:parent_id])
  end

  helper_method :current_teacher
  def current_teacher
	  @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
  end

  helper_method :current_center
  def current_center
	  @current_center ||= Center.find_by(id: session[:center_id])
  end
end
