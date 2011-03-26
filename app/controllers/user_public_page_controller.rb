class UserPublicPageController < ApplicationController

  before_filter :define_user

  @@image_limit = 5

  # params[:nick]
  def index
    @primary_image = Image.where(shown_date: @user.commented_images.last).first
    render 'no_comments' and return unless @primary_image
    @comment = @primary_image.comments.new
    @comments = Comment.where(image_id: @primary_image.id, user_id: @user.id)
    limit = @user.commented_images.size < @@image_limit ? @user.commented_images.size : @@image_limit
    @images = Image.where(shown_date: {:'$in' => @user.commented_images[-limit..-1]})
  end

  def index_with_date
    index = @user.commented_images.index params[:shown_date].split('-').join.to_i

    render :file => "#{Rails.root.to_s}/public/404.html" and return unless index
    redirect_to "/#{@user.nick}" and return if index + 1 == @user.commented_images.size

    @primary_image = Image.where(shown_date: @user.commented_images[index]).first
    @comment = @primary_image.comments.new
    @comments = Comment.where(image_id: @primary_image.id, user_id: @user.id)

    left_border = index - @@image_limit/2 -1 >= 0 ? index - @@image_limit/2 - 1 : 0
    right_border = index + @@image_limit/2 > @user.commented_images.size ? @user.commented_images.size : index + @@image_limit/2


    if right_border - left_border < @@image_limit and right_border + 1 != @@image_limit
      right_border += @@image_limit - (right_border - left_border)
    end

    @images = Image.where(shown_date: {:'$in' => @user.commented_images[left_border..right_border]})

    render :action => :index
  end

  private

    def define_user
      @user = User.where(:nick => params[:user_name]).first
    end
end