class PhotoPannel
  def initialize(user)
    @user = user
  end

  def like(photo)
    @user.liked_photos << photo
  end

  def unlike(photo)
    @user.liked_photos.destroy(photo)
  end
end