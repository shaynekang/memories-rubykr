class PhotoDecorator < Draper::Decorator
  delegate_all

  def image
    image_url = source.image || "noimage.png"
    h.image_tag image_url, class: 'photo'
  end

  def owner?(user)
    user and user.liked_photos.exists?(source)
  end

  def owner_name
    h.link_to source.owner.name, source.owner.facebook_link, target: '_blank'
  end

  def unlike
    h.button_to [:unlike, source], method: 'delete', class: 'btn' do
      "<i class=\"icon-thumbs-down\"></i> Unlike".html_safe
    end
  end

  def like
    h.button_to [:like, source], class: 'btn btn-primary' do
      "<i class=\"icon-thumbs-up\"></i> Like".html_safe
    end
  end

  def edit
    h.link_to [:edit, source], class: 'btn btn-warning' do
      "<i class=\"icon-edit\"></i> Edit".html_safe
    end
  end

  def destroy
    h.button_to source, method: 'delete', data: {confirm: 'Are you sure?'}, class: 'btn btn-danger' do
      "<i class=\"icon-remove\"></i> Destroy".html_safe
    end
  end
end