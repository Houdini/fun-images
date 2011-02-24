class WelcomeController < ApplicationController
  after_filter :if_no_images
  def index
    @primary_image = Image.find :first, :conditions => {:shown_date => Date.today}
    @primary_image = Image.desc(:shown_date).first unless @primary_image
    if @primary_image
      @comment = @primary_image.comments.new
      @images = Image.all(:conditions => {:shown_date.lt => @primary_image.shown_date + 1.day}, :limit => 5).asc(:shown_date)
    else
      render 'no_images'
    end



#    @date_today = Date.today
#    @days_to_show = 5
#    @date_to_show = params.has_key?(:shown_date) ? params[:shown_date].to_date : @date_today
#
#    redirect_to root_url if @date_to_show == Date.today if params.has_key? :shown_date
#
#    if @date_to_show < @date_today
#      #past
#      days_to_today = (@date_today - @date_to_show).to_i
#      if days_to_today > @days_to_show
#        # Если у нас есть запас, то мы можем показывать все картинки начиная с запрошенного дня
#        # То есть мы не показываем картинок до запрошенного дня
#        @images = Image.find :all,
#                             :conditions => {:shown_date.gt => @date_to_show - 1.day, :shown_date.lt => @date_today + 1.day},
#                             :limit => @days_to_show
#      else
#        # Запаса заведома нет, значит запрошенная картинка не будет первой и мы показываем
#        # некоторое количество картинок до этого дня
#        @images = Image.find :all, :conditions => {:shown_date.gt => @date_today - @days_to_show.days, :shown_date.lt => @date_today + 1.day}, :limit => @days_to_show
#      end
#    elsif @date_to_show == @date_today
#      #today
#      @images = Image.find :all, :conditions => {:shown_date.lt => @date_to_show + 1.day}, :limit => @days_to_show
#    else
#      # future
#    end
#
#    if @images.size == 0
#      render 'no_images'
#    else
#      if @images.last.shown_date < @date_to_show and !params.has_key? :shown_date
#        @primary_image = @images.last
#        @date_to_show = @primary_image.shown_date
#      else
#        @primary_image = @images.select{|image| image.shown_date == @date_to_show}[0]
#      end
#      @comment = @primary_image.comments.new
#    end

  end

  def index_with_date
    date_to_show = params[:shown_date].to_date
#    redirect_to root_url if date_to_show == Date.today

    @primary_image = Image.find :first, :conditions => {:shown_date => params[:shown_date].to_date}

  end

  private
  def if_no_images
  end

end
