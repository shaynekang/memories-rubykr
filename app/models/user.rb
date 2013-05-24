class User < ActiveRecord::Base
  has_many :photos, foreign_key: 'owner_id'

  has_many :likes
  has_many :liked_photos, :through => :likes, :source => :photo

  validates :provider, uniqueness: {:scope => :uid}, presence: true
  validates :uid, presence: true
  validates :nickname, uniqueness: true, presence: true

  def to_param
    self.nickname
  end

  def facebook_link
    "http://www.facebook.com/#{nickname}"
  end

  def self.find_or_create_with_omniauth(auth)
    user = where(provider: auth['provider'], uid: auth['uid']).first_or_create

    user.name = auth['info']['name'] unless auth['info']['name'].blank?
    user.nickname = auth['info']['nickname'] unless auth['info']['nickname'].blank?
    user.nickname = auth['extra']['username'] unless auth['extra']['username'].blank?
    user.email = auth['info']['email'] unless auth['info']['email'].blank?
    user.avatar = auth['info']['image'] unless auth['info']['image'].blank?

    user.token = auth['credentials']['token']

    user.save!

    user
  end
end