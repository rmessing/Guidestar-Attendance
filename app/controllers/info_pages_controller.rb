class InfoPagesController < ApplicationController

  def home
  # Layouts depend on the value of @nav and which users are logged in.  @nav = "root"
  # sets the correct layout for the apps landing page.  All users must be logged out to ensure proper layouts are rendered.
   
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

  # User help page to be developed.
  
  def help
  end
end
