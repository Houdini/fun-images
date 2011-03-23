class Admin::ImagesController < ::AdminController

  before_filter :convert_date_to_integer, :only => [:create, :update]

  # GET /images
  def index
    @images = Image.all
  end

  # GET /images/1
  def show
    @image = Image.find(params[:id])
  end

  # GET /images/new
  def new
    @image = Image.new
    render 'edit'
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  def create
    @image = Image.new(params[:image])
    @image.shown_date = @shown_date.to_i
    @image.user_id = current_user.id

    if @image.save
      redirect_to([:admin, @image], :notice => 'Image was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /images/1
  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image].merge({:shown_date => @shown_date.to_i}))
      redirect_to([:admin, @image], :notice => 'Image was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to admin_images_url
  end

  private
  def convert_date_to_integer
    @shown_date = Date.parse "#{params[:shown_date][:year]}-#{params[:shown_date][:month]}-#{params[:shown_date][:day]}"
  end
end
