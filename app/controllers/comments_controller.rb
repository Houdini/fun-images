class CommentsController < ApplicationController
  def create
    @image = Image.find params[:image_id]
    @comment = @image.comments.create! params[:comment]
    render :json => [].to_json
#    redirect_to :root_path, :notice => 'Ваш комментарий добавлен'
  end

  def report_spam
    render :nothing => true
  end

  def i_like
    image = Image.find :first, :conditions => {:shown_date => params[:image_id].to_date}
    comment = image.comments.find params[:comment_id]
    comment.rating += 1
    comment.save
#    comment.safely.inc :rating, 1
#    image.comments.update({:_id => params[:comment_id]}, {'$inc' => {:rating => 1}})
    render :nothing => true
  end
end
