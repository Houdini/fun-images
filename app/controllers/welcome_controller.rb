class WelcomeController < ApplicationController
  after_filter :if_no_images
  before_filter :if_smth_to_do
  @@image_limit = 5
  def index
    @primary_image = Image.find :first, :conditions => {:shown_date => Date.today}
    @primary_image = Image.desc(:shown_date).first unless @primary_image
    if @primary_image
      @comment = @primary_image.comments.new
      @images = Image.all(:conditions => {:shown_date.lt => @primary_image.shown_date + 1.day}, :limit => @@image_limit).asc(:shown_date)
    else
      render 'no_images'
    end
  end

  def index_with_date
    date_to_show = params[:shown_date].to_date
    redirect_to root_url and return if date_to_show == Date.today
    redirect_to root_url, :notice => t(:"notice.future_image") and return if date_to_show > Date.today

    @primary_image = Image.find :first, :conditions => {:shown_date => params[:shown_date].to_date}
    @images = Image.all(:conditions => {:shown_date.gt => @primary_image.shown_date - 2.days}, :limit => @@image_limit)

    redirect_to root_url and return if @images.size <= 1

    @comment = @primary_image.comments.new

    render :action => :index
  end

  private
  def if_no_images
  end

  def if_smth_to_do
    if signed_in? :user and cookies.has_key? 'do'
      session[:return_to] = request.request_uri
      redirect_to cookies.delete(:do)
    end
  end

end
