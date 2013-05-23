class Photo < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', counter_cache: true

  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user

  has_many :taggings
  has_many :tags, :through => :taggings

  validates :slug, uniqueness: true, presence: true
  validates :image, presence: true

  before_validation :generate_slug, :on => :create

  mount_uploader :image, PhotoUploader

  def self.latest
    order('created_at DESC')
  end

  def to_param
    self.slug
  end

  def tag_list
    tags.map{|tag| tag.name}.join(", ")
  end

private
  def generate_slug
    self.slug = "#{Time.now.strftime("%Y%m%d%H%M%S%L")}#{rand(10000)}"
  end
end