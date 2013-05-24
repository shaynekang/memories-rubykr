class Signup
  def authenticate!(auth)
    user = User.where(provider: auth['provider'], uid: auth['uid']).first_or_create

    info = auth['info']
    extra = auth['extra']

    user.name = info['name'] unless info['name'].blank?
    user.nickname = info['nickname'] unless info['nickname'].blank?
    user.nickname = extra['username'] unless extra['username'].blank?
    user.email = info['email'] unless info['email'].blank?
    user.avatar = info['image'] unless info['image'].blank?

    user.token = auth['credentials']['token']

    user.save!

    user
  end
end