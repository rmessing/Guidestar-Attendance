class InfoPagesController < ApplicationController

  def home
  # Layouts are a function of which users are loggin in.  These logouts ensure all users
  # are logged out when application is started.
  	  @nav = "root"
  	  if parent_logged_in?
         log_out_parent
      end
      if center_logged_in?  
         log_out_center 
      end
      if teacher_logged_in? 
         log_out_teacher 
      end
  end

  def help
  end
end
