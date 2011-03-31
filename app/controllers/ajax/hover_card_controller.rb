class Ajax::HoverCardController < ::ActionController::Base
  def show
    @user = User.where(_id: params[:id]).first
    if @user
      respond_to do |format|
        format.json {render json: {status: :ok, content: render_to_string(template: 'ajax/hover_card/show.html.haml')}}
      end
    else
      respond_to do |format|
        format.json {render json: {status: :error}}
      end
    end
  end
end