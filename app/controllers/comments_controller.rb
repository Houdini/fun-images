class CommentsController < ApplicationController
  def create
    @image = Image.find params[:image_id]
    @comment = @image.comments.create! params[:comment]
    render :json => [].to_json
#    redirect_to :root_path, :notice => 'Ваш комментарий добавлен'
  end
end
