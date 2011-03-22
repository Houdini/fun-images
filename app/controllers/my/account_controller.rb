class My::AccountController < ::UserController
  def index; end

  def change_nick
    if params.has_key? :account and params[:account].has_key? :nick
      current_user.nick = params[:account][:nick]
      current_user.validate_nick
      if current_user.errors.size == 0 and current_user.save
        redirect_to :back, :notice => t(:saved_successfully)
      else
        flash[:alert] = t :fix_errors
        render :index
      end
    else
      flash[:alert] = t :fix_errors
      render :index
    end
  end
end
