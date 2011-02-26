class AdminController < ActionController::Base
  layout 'admin'
  protect_from_forgery

  protected
  def super_admin_level_access
    if current_user
      if current_user.role > 0
        redirect_to new_user_session_path
      end
    end
  end
end
