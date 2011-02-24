class CommentsController < ApplicationController
  def new
  end

  def create
    @primary_image = Image.find params[:image_id]
    @comment = @primary_image.comments.new params[:comment]
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back, :notice => t(:save_comment_successfuly)}
        format.json {render :json => [].to_json}
      end
    else
      respond_to do |format|
        format.html {render :action => :new, :alert => t(:fix_errors)}
        format.json {render :json => {:error => t(:fix_errors)}}
      end
    end
  end

#  def report_spam
#    render :nothing => true
#  end

  def i_like
    image = Image.find :first, :conditions => {:shown_date => params[:image_id].to_date}
    comment = image.comments.find params[:comment_id]
    comment.like_users ||= []
    unless comment.like_users.index current_user.id
      comment.rating += 1
      comment.like_users << current_user.id
      comment.save
      current_user.user_like_comments.create! :comment_id => comment.id.to_s, :image_id => image.id.to_s, :body => comment.body
    end

    respond_to do |format|
      format.json {render :nothing => true}
      format.html {}
    end
  end
end
