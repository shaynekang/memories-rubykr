class PhotosController < ApplicationController
  before_filter :login_required, except: [:index, :show]
  before_filter :redirect_unless_me, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.latest
  end

  def show
    @photo = Photo.find_by_slug!(params[:id]).decorate
  end

  def new
    @photo = Photo.new
    @form = PhotoForm.new(@photo)
  end

  def create
    @photo = current_user.photos.build
    @form = PhotoForm.new(@photo)
    @form.save!(photo_params)
    redirect_to @photo, notice: "Successfully created Photo"
  rescue ActiveRecord::RecordInvalid
    render 'new'
  end

  def edit
    @photo = Photo.find_by_slug!(params[:id])
    @form = PhotoForm.new(@photo)
  end

  def update
    @photo = Photo.find_by_slug!(params[:id])
    @form = PhotoForm.new(@photo)
    @form.save!(photo_params)
    redirect_to @photo, notice: "Successfully updated Photo"
  rescue ActiveRecord::RecordInvalid
    render 'edit'
  end

  def destroy
    @photo = Photo.find_by_slug!(params[:id])
    @photo.destroy
    redirect_to :root, notice: "Photo was successfully destroyed"
  end

private
  def photo_params
    params.require(:photo_form).permit(:comment, :image, :tag_list)
  end

  def redirect_unless_me
    photo = Photo.find_by_slug!(params[:id])
    redirect_to :back, notice: "Sorry, you have no permission." unless photo.owner == current_user
  end
end