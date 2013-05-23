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
end