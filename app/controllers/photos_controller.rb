class PhotosController < ApplicationController
  before_filter :login_required, except: [:index, :show]
  before_filter :redirect_unless_me, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.latest
  end

  def show
    @photo = Photo.find_by_slug!(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    tag_list = params[:photo].delete("tag_list")

    @photo = current_user.photos.build(photo_params)
    @photo.save!

    @photo.tags.clear
    tags = tag_list.split(",").map{|tag| tag.strip}
    tags.each do |tag|
      resource = Tag.find_or_create_by_name(tag)
      @photo.tags << resource unless @photo.tags.exists?(resource)
    end

    @graph = Koala::Facebook::API.new(@photo.owner.token)
    @graph.put_picture("public/#{@photo.image.url}", {"message" => "#{@photo.comment}"})

    redirect_to @photo, notice: "Successfully created Photo"
  rescue ActiveRecord::RecordInvalid
    render 'new'
  end

  def edit
    @photo = Photo.find_by_slug!(params[:id])
  end

  def update
    tag_list = params[:photo].delete("tag_list")

    @photo = Photo.find_by_slug!(params[:id])
    @photo.update_attributes!(photo_params)

    @photo.tags.clear
    tags = tag_list.split(",").map{|tag| tag.strip}
    tags.each do |tag|
      resource = Tag.find_or_create_by_name(tag)
      @photo.tags << resource unless @photo.tags.exists?(resource)
    end

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
    params.require(:photo).permit(:comment, :image, :tag_list)
  end

  def redirect_unless_me
    photo = Photo.find_by_slug!(params[:id])
    redirect_to :back, notice: "Sorry, you have no permission." unless photo.owner == current_user
  end
end