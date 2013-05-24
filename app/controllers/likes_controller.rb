class LikesController < ApplicationController
  def create
    photo = Photo.find_by_slug!(params[:id])

    pannel = PhotoPannel.new(current_user)
    pannel.like(photo)

    redirect_to photo, notice: "Successfully liked Photo"
  end

  def destroy
    photo = Photo.find_by_slug!(params[:id])

    pannel = PhotoPannel.new(current_user)
    pannel.unlike(photo)

    redirect_to photo, notice: "Successfully unliked Photo"
  end
end