class WelcomeController < ApplicationController
  before_filter :if_smth_to_do
  @@image_limit = 5
  def index
    date_today = Date.today.to_i
    @primary_image = Image.find :first, :conditions => {:shown_date => date_today}
    @primary_image = Image.desc(:shown_date).first unless @primary_image
    if @primary_image
      @comment = @primary_image.comments.new
      @images = Image.where(shown_date: {:'$gt' => (@primary_image.shown_date.to_date - @@image_limit), :'$lte' => date_today}).asc(:shown_date)
    else
      render 'no_images'
    end
  end

  def index_with_date
    date_to_show, date_today = params[:shown_date].split('-').join.to_i, Date.today.to_i
    redirect_to root_url and return if date_to_show == date_today
    redirect_to root_url, :notice => t(:"notice.future_image") and return if date_to_show > date_today

    @primary_image = Image.find :first, :conditions => {:shown_date => params[:shown_date].to_date}
    pr_image_sh_date = @primary_image.shown_date.to_date

    offset = (Date.today - @primary_image.shown_date.to_date).to_i
    offset = 0 unless offset < @@image_limit/2

    @images = Image.where(shown_date: {:'$gte' => (pr_image_sh_date - @@image_limit/2 - offset).to_i, :'$lte' => (pr_image_sh_date + @@image_limit/2).to_i}).asc(:shown_date)

    if @images.count < @@image_limit
      @images = @images.to_a + Image.where(shown_date: {:'$gt' => @images.last.shown_date, :'$lte' => date_today}).asc(:shown_date).limit(@@image_limit - @images.count).to_a
    end

    redirect_to root_url and return if @images.size <= 1

    @comment = @primary_image.comments.new

    render :action => :index
  end

  private
  def if_smth_to_do
    if signed_in? :user and cookies.has_key? 'do'
      session[:return_to] = request.request_uri
      redirect_to cookies.delete(:do)
    end
  end

end
