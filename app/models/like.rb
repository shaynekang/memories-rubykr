class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  before_validation :log_liked_at

private
  def log_liked_at
    self.liked_at = DateTime.now
  end
end