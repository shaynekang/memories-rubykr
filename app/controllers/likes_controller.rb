class LikesController < ApplicationController
  def create
    photo = Photo.find_by_slug!(params[:id])
    current_user.liked_photos << photo
    redirect_to photo, notice: "Successfully liked Photo"
  end

  def destroy
    photo = Photo.find_by_slug!(params[:id])
    current_user.liked_photos.destroy(photo)
    redirect_to photo, notice: "Successfully unliked Photo"
  end
end