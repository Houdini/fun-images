class Admin::UsersController < ::AdminController

  before_filter :load_user, :except => :index

  def index
    @users = User.desc(:created_at).page params[:page]
    @total_users = User.count
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes params[:user]
      redirect_to [:admin, @user], :notice => 'User was successfully updated'
    else
      render :edit
    end
  end

  protected

    def load_user
      @user = User.where(_id: params[:id]).first
    end

end