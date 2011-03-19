class Admin::CommentsController < ::AdminController
  def destroy
    @image = Image.find params[:image_id]
    @comment = @image.comments.find params[:id]
    @comment.destroy

    redirect_to admin_image_url(@image)
  end
end
