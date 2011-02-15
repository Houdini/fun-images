class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery

  protected
  def super_admin_level_access
    if current_user
      if current_user.role > 0
        redirect_to new_user_session_path
      end
    end
  end
  
  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
end