class Admin::ImagesController < ::AdminController

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
    @image.user_id = current_user.id

    if @image.save
      redirect_to(@image, :notice => 'Image was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /images/1
  def update
    @image = Image.find(params[:id])

    if @image.update_attributes(params[:image])
      redirect_to(@image, :notice => 'Image was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to images_url
  end
end
