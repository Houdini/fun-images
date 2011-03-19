class CommentsController < ApplicationController
  before_filter :if_not_signed_in

  def new
  end

  def create
    @primary_image = Image.find params[:image_id]
    @comment = @primary_image.comments.new params[:comment]
    @images = []
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back, :notice => t(:save_comment_successfully)}
        format.json {render :json => {:status => :ok, :body => @comment.body}}
      end
    else
      respond_to do |format|
        format.html {render :new, :alert => t(:fix_errors)}
        format.json {render :json => {:status => :error, :alert => t(:fix_errors), :errors => @comment.errors}}
      end
    end
  end

  def i_like
    image = Image.find :first, :conditions => {:shown_date => params[:image_id].to_date}
    comment = image.comments.find params[:comment_id]
    comment.like_users ||= []
    unless comment.like_users.index current_user.id

      comment.rating += 1
      comment.like_users << current_user.id
      comment.save

      comment_author = comment.user_author
      comment_author.rating ||= 0
      comment_author.rating += 1
      comment_author.save

      current_user.like_comments << comment.id.to_s
      current_user.save

      respond_to do |format|
        format.json {render :json => {:status => :ok, :like => :'1'}}
        format.html {redirect_to :back, :notice => t(:'notice.thanks_for_comment', :nick => current_user.nick)}
      end    
    else
      respond_to do |format|
        format.json {render :json => {:status => :double_vote}}
        format.html {redirect_to :back, :alert => t(:you_have_already_voted)}
      end
    end
  end

  def dont_like
    image = Image.find :first, :conditions => {:shown_date => params[:image_id].to_date}
    comment = image.comments.find params[:comment_id]
    if comment.like_users and comment.like_users.index current_user.id

      comment.rating -= 1
      comment.like_users.delete_if{|user_id| user_id == current_user.id}
      comment.save

      comment_author = comment.user_author
      comment_author.rating ||= 1
      comment_author.rating -= 1
      comment_author.save

      current_user.like_comments.delete_if{|c| c == comment.id.to_s}
      current_user.save

      respond_to do |format|
        format.json {render :json => {:status => :ok, :like => :'0'}}
        format.html {redirect_to :back, :notice => t(:'notice.dislike_comment', :nick => current_user.nick)}
      end
    end
  end

  private
  def if_not_signed_in
    unless signed_in? :user
      respond_to do |format|
        format.html {redirect_to new_user_registration_path(:after => request.env['PATH_INFO'])}
        format.json do 
          render :json => {:error => 'sign_up', :title => t(:register_title), :form => render_to_string(:template => 'devise/registrations/_new_form.html.haml')}
        end
      end
      return
    end    
  end
end
