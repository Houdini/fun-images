class CommentsController < ApplicationController
  before_filter :if_not_signed_in
  before_filter :load_image_and_comment, only: [:dont_like, :i_like, :edit, :update, :destroy]
  before_filter :if_not_author, only: [:edit, :update, :destroy]
  before_filter :if_not_editable, only: [:edit, :update, :destroy]

  def new
  end

  def edit
    @images = []
    @comments = @primary_image.comments
    render template: 'welcome/index'
  end

  def update
    @images = []
    @comments = @primary_image.comments

    if @comment.update_attribute(:body, params[:comment][:body])
      redirect_to "/#{@primary_image.shown_date.to_string_date}", notice: t(:comment_updated)
    else
      render template: 'welcome/index', alert: t(:fix_errors)
    end

  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to :back, notice: t(:'notice.comment_deleted')}
      format.json {render json: {status: :ok, message: 'notice.comment_deleted'}}
    end
  end

  def create
    @primary_image = Image.find params[:image_id]
    @comment = @primary_image.comments.new params[:comment]
    @comments = @primary_image.comments
    @images = []
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back, notice: t(:save_comment_successfully)}
        format.json {render json: {status: :ok, body: @comment.body}}
      end
    else
      respond_to do |format|
        format.html {render :new, alert: t(:fix_errors)}
        format.json {render json: {status: :error, alert: t(:fix_errors), errors: @comment.errors}}
      end
    end
  end

  def i_like
    @comment.like_users ||= []
    if !@comment.like_users.index(current_user.id) and @comment.user_id != current_user.id

      @comment.rating += 1
      @comment.like_users << current_user.id
      @comment.save

      comment_author = @comment.user_author
      comment_author.rating ||= 0
      comment_author.rating += 1
      comment_author.save

      current_user.like_comments << @comment.id.to_s
      current_user.save

      respond_to do |format|
        format.json {render json: {status: :ok, like: :'1'}}
        format.html {redirect_to :back, notice: t(:'notice.thanks_for_comment', nick: current_user.nick)}
      end
    elsif @comment.user_id == current_user.id
      respond_to do |format|
        format.json {render json: {status: :error, message: t(:'alert.author_vote')}}
        format.html {redirect_to :back, alert: t(:'alert.author_vote')}
      end
    else
      respond_to do |format|
        format.json {render json: {status: :double_vote}}
        format.html {redirect_to :back, alert: t(:you_have_already_voted)}
      end
    end
  end

  def dont_like
    if @comment.like_users and @comment.like_users.index current_user.id

      @comment.rating -= 1
      @comment.like_users.delete_if{|user_id| user_id == current_user.id}
      @comment.save

      comment_author = @comment.user_author
      comment_author.rating ||= 1
      comment_author.rating -= 1
      comment_author.save

      current_user.like_comments.delete_if{|c| c == @comment.id.to_s}
      current_user.save

      respond_to do |format|
        format.json {render json: {status: :ok, like: :'0'}}
        format.html {redirect_to :back, notice: t(:'notice.dislike_comment', nick: current_user.nick)}
      end
    end
  end

  private

    def if_not_signed_in
      unless signed_in? :user
        respond_to do |format|
          format.html {redirect_to new_user_registration_path(after: request.env['PATH_INFO'])}
          format.json do
            render json: {error: 'sign_up', title: t(:register_title), form: render_to_string(template: 'devise/registrations/_new_form.html.haml')}
          end
        end
        return
      end
    end

    def load_image_and_comment
      @comment = Comment.where(_id: params[:comment_id] || params[:id]).first
      @primary_image = @comment.image
    end

    def if_not_author
      if @comment.user_id != current_user.id
        respond_to do |format|
          format.html {redirect_to :back, alert: t(:'alert.you_are_not_author')}
          format.json {render json: {status: :error, message: 'alert.you_are_not_author'}}
        end
      end
    end

    def if_not_editable
      unless @comment.editable?
        respond_to do |format|
          format.html {redirect_to :back, alert: t(:'alert.you_cant_edit_comment')}
          format.json {render json: {status: :error, message: 'alert.you_cant_edit_comment'}}
        end
      end
    end

end
