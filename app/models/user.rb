class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  
  def return_recent_posts
    Post.where(users_id: id).order(created_at: :DESC).limit(3)
  end
end
